from pathlib import Path
import subprocess,plistlib,hashlib,json,shutil,os
target=os.environ.get('VCORE_DMG_TARGET','darwin-arm64')
arch=target.split('-')[-1]
native='x64' if os.uname().machine=='x86_64' else os.uname().machine
assert arch==native and arch in ['arm64','x64']
build=os.environ.get('VCORE_DMG_BUILD','2026.09.30-release-candidate.21')
expected=os.environ['VCORE_DMG_PAYLOAD_SHA256']
label='Apple-Silicon' if arch=='arm64' else 'Intel'
here=Path(__file__).resolve().parent
out=Path('dmg-output');out.mkdir(exist_ok=True)
stage=Path('dmg-stage');stage.mkdir()
app=stage/'VCore Pulse.app';contents=app/'Contents';resources=contents/'Resources';macos=contents/'MacOS'
resources.mkdir(parents=True);macos.mkdir()
installer=Path('installer.sh');digest=hashlib.sha256(installer.read_bytes()).hexdigest()
assert digest==expected
shutil.copy2(installer,resources/'installer.sh');shutil.copy2(here/'install-and-open.sh',resources/'install-and-open.sh')
shutil.copy2(here/'translations.json',resources/'translations.json')
(resources/'payload.sha256').write_text(digest+'\n')
(resources/'architecture').write_text('arm64\n' if arch=='arm64' else 'x86_64\n')
plist={'CFBundleIdentifier':'com.voigtcore.pulse.launcher','CFBundleName':'VCore Pulse','CFBundleDisplayName':'VCore Pulse','CFBundleExecutable':'PulseLauncher','CFBundleIconFile':'AppIcon','CFBundlePackageType':'APPL','CFBundleShortVersionString':'2.2.0','CFBundleVersion':'21.1','LSMinimumSystemVersion':'13.0','NSHighResolutionCapable':True}
(contents/'Info.plist').write_bytes(plistlib.dumps(plist))
icons=Path('Pulse.iconset');icons.mkdir()
for n in [16,32,128,256,512]:
 for scale in [1,2]:
  p=icons/f'icon_{n}x{n}{"@2x" if scale==2 else ""}.png'
  subprocess.run(['sips','-z',str(n*scale),str(n*scale),str(here/'Pulse.png'),'--out',str(p)],check=True,stdout=subprocess.DEVNULL)
subprocess.run(['iconutil','-c','icns',str(icons),'-o',str(resources/'AppIcon.icns')],check=True)
subprocess.run(['swiftc','-target',('arm64' if arch=='arm64' else 'x86_64')+'-apple-macos13.0','-O','-framework','Cocoa',str(here/'Launcher.swift'),'-o',str(macos/'PulseLauncher')],check=True)
subprocess.run(['codesign','--force','--sign','-',str(app)],check=True)
subprocess.run(['codesign','--verify','--deep','--strict',str(app)],check=True)
subprocess.run(['bash','-n',str(resources/'install-and-open.sh')],check=True)
guide='''VCore Pulse 2.2 · Apple Silicon · build 20

PORTUGUÊS
1. Abra VCore Pulse.app neste disco.
2. Clique em “Instalar e abrir Pulse”. O histórico e a licença existentes são preservados.
3. Autorize o Acesso às Chaves se o macOS solicitar. Aguarde a abertura do painel no navegador.
4. Depois de concluir, ejete o disco. Reabra pelo VCore Pulse em ~/Applications (Aplicativos do usuário).
O serviço inicia ao entrar na conta do Mac; o navegador só abre quando você solicita pelo aplicativo.

Este DMG ainda NÃO tem assinatura Developer ID nem notarização Apple. A assinatura ad hoc interna não identifica a VoigtCore perante o Gatekeeper. O macOS pode bloquear a primeira abertura. Consulte o procedimento oficial de aprovação por aplicativo: https://support.apple.com/102445 . Não desative o Gatekeeper, não remova a quarentena pelo Terminal e não use sudo.
Se a política do Mac não permitir abrir, aguarde a distribuição notarizada. O DMG não executa nada só por ser montado.

Não use removedor para atualizar. Faça backup pelo Pulse; preserve banco e chaves. SAFE mantém históricos originais e não libera espaço automaticamente. Arquivos cifrados podem não diminuir com compressão.

ENGLISH
1. Open VCore Pulse.app on this disk.
2. Click “Install and open Pulse”. Existing history and licensing are retained.
3. Approve Keychain access if macOS requests it. Wait for the browser dashboard.
4. Eject this disk after completion. Reopen VCore Pulse from ~/Applications.
The service starts at login; the browser opens only when requested through the app.

This DMG is NOT Developer ID signed or Apple-notarized. Internal ad hoc signing does not establish publisher trust. Gatekeeper may block the first launch. See Apple's per-app approval guidance: https://support.apple.com/102445 . Do not disable Gatekeeper, strip quarantine in Terminal, or use sudo. If your Mac's policy prevents launch, wait for a notarized distribution. Mounting a DMG does not automatically execute its app.

Update without uninstalling. Back up through Pulse and retain keys/data. SAFE retains original archives and does not reclaim disk space automatically. Encrypted files may not compress meaningfully.

Support: suporte@voigtcore.com.br
'''
guide=guide.replace('Apple Silicon · build 20',label+' · build 21')
translations=json.loads((here/'translations.json').read_text())
for language in ['es','zh-Hans','zh-Hant']:
 guide+='\n'+language+'\n'+translations[language]['body']+'\n'+translations[language]['warning']+'\n'
(stage/'LEIA-ME — READ ME.txt').write_text(guide,encoding='utf-8')
dmg=out/f'VCorePulse-2.2.0-macOS-{label}-build21.dmg'
subprocess.run(['hdiutil','create','-size','256m','-fs','HFS+','-volname','VCore Pulse 2.2 '+label,'-srcfolder',str(stage),'-ov','-format','UDZO',str(dmg)],check=True)
subprocess.run(['hdiutil','verify',str(dmg)],check=True)
mount=Path('/tmp/vcore-dmg-verify');mount.mkdir(exist_ok=True)
subprocess.run(['hdiutil','attach','-nobrowse','-readonly','-mountpoint',str(mount),str(dmg)],check=True)
try:
 payload=mount/'VCore Pulse.app/Contents/Resources/installer.sh'
 assert hashlib.sha256(payload.read_bytes()).hexdigest()==digest
 subprocess.run(['codesign','--verify','--deep','--strict',str(mount/'VCore Pulse.app')],check=True)
 assert ('arm64' if arch=='arm64' else 'x86_64') in subprocess.check_output(['lipo','-archs',str(mount/'VCore Pulse.app/Contents/MacOS/PulseLauncher')],text=True)
 # Exercise the mounted bundle's actual installer. Native runtime acceptance follows separately.
 testhome=Path('/tmp/pulse-dmg-install-proof').resolve();testhome.mkdir(exist_ok=True)
 env=dict(os.environ,VCORE_INSTALL_ROOT=str(testhome/'app'),VCORE_DATA_ROOT=str(testhome/'data'))
 subprocess.run(['sh',str(payload),'--no-start'],env=env,check=True)
 assert json.loads((testhome/'app/package.json').read_text())['build']==build
except:raise
finally:subprocess.run(['hdiutil','detach',str(mount)],check=True)
record={'file':dmg.name,'bytes':dmg.stat().st_size,'sha256':hashlib.sha256(dmg.read_bytes()).hexdigest(),'payloadSha256':digest,'architecture':arch,'build':build,'wrapperVersion':'21.1','dmgVerified':True,'mountedInstallerTest':'PASS','developerIDSigned':False,'notarized':False,'guiKeychainLoginAcceptance':'PENDING_USER_MAC'}
(out/'DMG-MANIFEST.json').write_text(json.dumps(record,indent=2))
(out/'SHA256SUMS-DMG.txt').write_text(record['sha256']+'  '+dmg.name+'\n')
shutil.copy2(stage/'LEIA-ME — READ ME.txt',out/'INSTALL-DMG.txt')
print(json.dumps(record))
