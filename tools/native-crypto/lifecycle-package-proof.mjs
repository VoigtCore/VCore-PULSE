// Disposable acceptance fixture only; never run against an operator's database.
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import assert from 'node:assert/strict';
import {pathToFileURL} from 'node:url';
const app=path.resolve(process.argv[2]);
const output=path.resolve(process.argv[3]);
const root=path.resolve(process.env.PULSE_DATA_DIR||'');
assert.equal(process.env.VCORE_LIFECYCLE_DISPOSABLE_PROOF,'1');
assert.ok(root.includes('pulse-package-proof-')||root.includes('validation-legacy-'));
assert.equal(process.env.VCORE_COMMERCE_URL,'http://127.0.0.1:9');
const load=p=>import(pathToFileURL(path.join(app,p)));
const {PulseRuntime}=await load('pulse/runtime.js');
const {db}=await load('pulse/database.js');
const {databaseActivity}=await load('pulse/database-lifecycle/activity-gate.js');
const {loadLifecyclePolicy}=await load('pulse/database-lifecycle/policy.js');
const runtime=await new PulseRuntime().start();runtime.stopScheduling();
const digest=rows=>crypto.createHash('sha256').update(JSON.stringify(rows)).digest('hex');
const identity=()=>digest(db().prepare('SELECT id,first_seen_at FROM machine ORDER BY id').all());
const license=()=>digest(db().prepare('SELECT machine_id,license_key,license_secret,license_fingerprint,plan,started_at,expires_at FROM licenses ORDER BY id').all());
const evidence={platform:process.platform,arch:process.arch,status:'RUNNING',disposable:true};
try {
  assert.equal(runtime.lifecycle.policy.mode,'enabled','Package default must enable automation');
  const before={identity:identity(),license:license(),telemetry:db().prepare('SELECT COUNT(*) n FROM telemetry').get().n};
  assert.ok(before.telemetry>0);
  // Lower only the disposable fixture's trigger, retaining disk and integrity safeguards.
  runtime.lifecycle.policy=loadLifecyclePolicy({...runtime.lifecycle.policy,prepareRotationBytes:1});
  const rotation=await runtime.temporalMaintenance.rotateIfRequired();
  assert.equal(rotation.state,'ACTIVE');assert.equal(rotation.metrics.encryptedAtRest,true);
  assert.equal(identity(),before.identity);assert.equal(license(),before.license);
  const period={start:'2000-01-01T00:00:00Z',end:'2100-01-01T00:00:00Z'};
  const history=runtime.lifecycle.queryPeriod({...period,query:d=>d.prepare('SELECT id,captured_at FROM telemetry ORDER BY id').all()});
  assert.ok(history.results.length>=before.telemetry);
  const runs=db().prepare("SELECT COUNT(*) n FROM memory_database_lifecycle_runs WHERE state='ACTIVE' AND completed_at IS NOT NULL AND target_database_id IS NOT NULL").get().n;
  assert.ok(runs>=1);
  const compression=await runtime.temporalMaintenance.compressNext();
  assert.equal(compression.state,'AVAILABLE');assert.equal(compression.originalRetained,true);
  const loaded=await runtime.lifecycle.queryPeriodAsync({...period,query:d=>d.prepare('SELECT id,captured_at FROM telemetry ORDER BY id').all()});
  assert.deepEqual(loaded.results,history.results);
  // Exercise the V8 argument-limit regression through the installed package.
  const many=runtime.lifecycle.queryPeriod({...period,query:d=>d.prepare('WITH RECURSIVE n(x) AS (SELECT 1 UNION ALL SELECT x+1 FROM n WHERE x<210000) SELECT x FROM n').all()});
  assert.ok(many.results.length>=210000);assert.equal(many.results[0].x,1);
  assert.equal(runtime.lifecycle.registry().validateChain().valid,true);
  evidence.status='PASS';evidence.encryptedRotation=true;evidence.rotationCount=runs;
  evidence.identityPreserved=true;evidence.licensePreserved=true;evidence.historicalRows=history.results.length;
  evidence.largeQueryRows=many.results.length;evidence.compression={state:compression.state,originalRetained:true,originalBytes:compression.originalBytes,compressedBytes:compression.compressedBytes};
} catch(e) { evidence.status='FAIL';evidence.error=e.code||e.message;process.exitCode=1; }
finally {
  await databaseActivity.shutdown({work:({orderly})=>runtime.stop({orderly})});
  fs.writeFileSync(output,JSON.stringify(evidence,null,2));console.log(JSON.stringify(evidence));
  process.exit(evidence.status==='PASS'?0:1);
}
