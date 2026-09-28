const fs=require('node:fs'),path=require('node:path'),crypto=require('node:crypto'),assert=require('node:assert/strict'),os=require('node:os');
const Driver=require(path.join(process.cwd(),'lib'));
const binding=path.join(process.cwd(),'build/Release/better_sqlite3.node');
const temp=fs.mkdtempSync(path.join(os.tmpdir(),'vcore-crypto-proof-'));
const database=path.join(temp,'encrypted.db'),copy=path.join(temp,'backup.db');
const key=crypto.randomBytes(32).toString('hex');
let db=new Driver(database,{nativeBinding:binding});
db.exec(`PRAGMA key="x'${key}'"`);
const version=db.pragma('cipher_version',{simple:true});assert.equal(version,'4.18.0 community');
db.pragma('journal_mode=WAL');db.exec('CREATE TABLE proof(value TEXT)');db.prepare('INSERT INTO proof VALUES(?)').run('DISPOSABLE_PROOF');
db.exec(`ATTACH DATABASE '${copy}' AS backup KEY "x'${key}'";SELECT sqlcipher_export('backup');DETACH DATABASE backup;`);
db.pragma('wal_checkpoint(TRUNCATE)');db.close();
for(const file of [database,copy]){
 const bytes=fs.readFileSync(file);assert.notEqual(bytes.subarray(0,16).toString(),'SQLite format 3\0');assert.equal(bytes.includes(Buffer.from('DISPOSABLE_PROOF')),false);
 db=new Driver(file,{nativeBinding:binding});db.exec(`PRAGMA key="x'${'00'.repeat(32)}'"`);assert.throws(()=>db.prepare('SELECT * FROM proof').all());db.close();
 db=new Driver(file,{nativeBinding:binding});db.exec(`PRAGMA key="x'${key}'"`);assert.equal(db.prepare('SELECT value FROM proof').get().value,'DISPOSABLE_PROOF');db.close();
}
const out=process.env.NATIVE_OUTPUT;fs.mkdirSync(out,{recursive:true});fs.copyFileSync(binding,path.join(out,'better_sqlite3.node'));
fs.cpSync(path.join(process.cwd(),'lib'),path.join(out,'driver/lib'),{recursive:true});
fs.writeFileSync(path.join(out,'driver/package.json'),JSON.stringify({name:'@voigtcore/sqlcipher-driver',private:true,version:'13.0.3',main:'lib/index.js',type:'commonjs',license:'MIT'}));
fs.mkdirSync(path.join(out,'notices'));fs.copyFileSync(path.join(process.cwd(),'LICENSE'),path.join(out,'notices/BETTER-SQLITE3-LICENSE.txt'));
fs.copyFileSync(path.join(process.env.WORK,'sqlcipher/LICENSE.md'),path.join(out,'notices/SQLCIPHER-LICENSE.md'));
const files={};function scan(dir){for(const e of fs.readdirSync(dir,{withFileTypes:true})){const file=path.join(dir,e.name);if(e.isDirectory())scan(file);else files[path.relative(out,file).split(path.sep).join('/')]=crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');}}scan(out);
fs.writeFileSync(path.join(out,'RUNTIME-MANIFEST.json'),JSON.stringify({schema:1,platform:process.platform,architecture:process.arch,node:process.versions.node,napi:10,driver:'better-sqlite3 13.0.3',sqlCipher:version,sourceCommit:'63697beb0fafcb61faa7a3e6fd267036548ab11b',cryptoProvider:process.platform==='darwin'?'Apple CommonCrypto':'OpenSSL static (system build)',files},null,2));
fs.writeFileSync(path.join(out,'PROOF.json'),JSON.stringify({status:'PASS',platform:process.platform,architecture:process.arch,node:process.versions.node,sqlCipher:version,encryptedHeader:true,plaintextAbsent:true,wrongKeyDenied:true,reopen:true,encryptedBackup:true,realPayments:0},null,2));
fs.rmSync(temp,{recursive:true,force:true});console.log('Native encrypted database proof PASS: '+process.platform+'-'+process.arch);
