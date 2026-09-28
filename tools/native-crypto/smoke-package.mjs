import fs from 'node:fs';import os from 'node:os';import path from 'node:path';import crypto from 'node:crypto';import assert from 'node:assert/strict';import {spawn,spawnSync} from 'node:child_process';
const out=path.resolve('validation-output');fs.mkdirSync(out,{recursive:true});
const root=fs.mkdtempSync(path.join(os.tmpdir(),'pulse-package-proof-')),home=path.join(root,'home'),app=path.join(root,'install'),data=path.join(root,'data');fs.mkdirSync(home);
const keyDir=path.join(root,'test-keys');fs.mkdirSync(keyDir,{mode:0o700});
for(const name of ['database','master'])fs.writeFileSync(path.join(keyDir,name),crypto.randomBytes(32).toString('base64'),{mode:0o600});
const env={...process.env,HOME:home,VCORE_INSTALL_ROOT:app,VCORE_DATA_ROOT:data,VCORE_NO_BROWSER:'1',PULSE_HOST:'127.0.0.1',PULSE_PORT:'4198',VCORE_COMMERCE_URL:'http://127.0.0.1:9',VCORE_COMMERCE_PORTAL_URL:'http://127.0.0.1:9',PULSE_DATABASE_KEY_FILE:path.join(keyDir,'database'),PULSE_MASTER_KEY_FILE:path.join(keyDir,'master')};
delete env.GH_TOKEN;delete env.GITHUB_TOKEN;
const proof={platform:process.platform,architecture:process.arch,status:'RUNNING',bankConnections:0,keyStorage:'disposable external keys; native OS vault tested separately',steps:[]};let child;
const delay=ms=>new Promise(r=>setTimeout(r,ms));
function exec(command,args){const r=spawnSync(command,args,{env,encoding:'utf8',timeout:180000});if(r.status!==0)throw Error(`${command} failed (${r.status}): ${r.stderr}\n${r.stdout}`);return r.stdout;}
async function request(route,options={}){return fetch('http://127.0.0.1:4198'+route,{...options,signal:AbortSignal.timeout(30000)});}
async function start(){
 const log=fs.openSync(path.join(root,'runtime.log'),'a');child=spawn(path.join(app,'start-vcore-pulse.sh'),[],{env,stdio:['ignore',log,log]});fs.closeSync(log);
 for(let i=0;i<90;i++){if(child.exitCode!==null)throw Error('Runtime exited: '+fs.readFileSync(path.join(root,'runtime.log'),'utf8').slice(-3000));try{const r=await request('/api/pulse/health');if(r.ok)return await r.json();}catch{}await delay(1000);}throw Error('Runtime health timeout');
}
async function stop(){const r=await request('/api/pulse/shutdown',{method:'POST'});assert.equal(r.status,200);for(let i=0;i<30&&child.exitCode===null;i++)await delay(500);assert.notEqual(child.exitCode,null,'Normal shutdown required');}
try{
 const installed=exec('sh',[path.resolve('installer.sh'),'--no-start']);assert.match(installed,/Installed VCore Pulse 2.2/);proof.steps.push('INSTALL_PASS');
 const health=await start();assert.equal(health.status,'ok');proof.steps.push('HEALTH_PASS');
 const about=await (await request('/api/pulse/support/about')).json();assert.equal(about.build,'2026.09.28-release-candidate.16-port.1');proof.build=about.build;
 const malicious=await request('/api/pulse/license/customer',{method:'POST',headers:{Origin:'https://untrusted.invalid','Content-Type':'application/json'},body:'{}'});assert.equal(malicious.status,403);proof.steps.push('CROSS_ORIGIN_DENIED');
 const pdf=await request('/api/pulse/report?period=24h&format=pdf&lang=pt-BR');assert.equal(pdf.status,200);const bytes=Buffer.from(await pdf.arrayBuffer());assert.equal(bytes.subarray(0,5).toString(),'%PDF-');proof.pdfBytes=bytes.length;proof.steps.push('PDF_PASS');
 await stop();proof.steps.push('SHUTDOWN_PASS');
 assert.notEqual(fs.readFileSync(path.join(data,'pulse.db')).subarray(0,16).toString(),'SQLite format 3\0');proof.steps.push('ENCRYPTED_DATABASE_PASS');
 const dbHash=crypto.createHash('sha256').update(fs.readFileSync(path.join(data,'pulse.db'))).digest('hex');
 exec('sh',[path.resolve('installer.sh'),'--no-start']);assert.equal(crypto.createHash('sha256').update(fs.readFileSync(path.join(data,'pulse.db'))).digest('hex'),dbHash);proof.steps.push('REINSTALL_PRESERVES_DATABASE');
 await start();await stop();proof.steps.push('RESTART_PASS');
 const manifest=path.join(app,'pulse/vendor/sqlcipher',process.platform+'-'+process.arch,'RUNTIME-MANIFEST.json');fs.appendFileSync(manifest,' ');
 const node=path.join(app,'runtime/bin/node');const tamper=spawnSync(node,['--input-type=module','-e',`const m=await import(${JSON.stringify('file://'+path.join(app,'pulse/sqlite-runtime.js'))});console.log(m.probeSqlCipherRuntime().errorCode);`],{env,encoding:'utf8'});assert.match(tamper.stdout,/SQLCIPHER_ARTIFACT_INTEGRITY_FAILED/);proof.steps.push('MANIFEST_TAMPER_DENIED');
 proof.status='PASS';
}catch(error){proof.status='FAIL';proof.error=String(error.message);process.exitCode=1;}
finally{if(child&&child.exitCode===null)child.kill('SIGTERM');fs.writeFileSync(path.join(out,'proof.json'),JSON.stringify(proof,null,2));console.log(JSON.stringify(proof));}
