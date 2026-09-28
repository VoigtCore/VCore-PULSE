import fs from 'node:fs';import crypto from 'node:crypto';
if(!/^\d+$/.test(process.env.ASSET_ID)||!/^[a-f0-9]{64}$/.test(process.env.ASSET_SHA))throw Error('Invalid approved asset');
const r=await fetch(`https://api.github.com/repos/VoigtCore/VCore-PULSE/releases/assets/${process.env.ASSET_ID}`,{redirect:'manual',headers:{Authorization:`Bearer ${process.env.GH_TOKEN}`,Accept:'application/octet-stream','X-GitHub-Api-Version':'2022-11-28'}});
let response=r;
if(r.status===302){const url=new URL(r.headers.get('location'));if(url.protocol!=='https:'||!url.hostname.endsWith('.githubusercontent.com'))throw Error('Unexpected download host');response=await fetch(url);}
if(!response.ok)throw Error('Asset unavailable '+response.status);
const body=Buffer.from(await response.arrayBuffer());if(crypto.createHash('sha256').update(body).digest('hex')!==process.env.ASSET_SHA)throw Error('Installer hash mismatch');
fs.writeFileSync('installer.sh',body,{mode:0o700});
console.log('Approved installer hash verified');
