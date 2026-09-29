# VCore Pulse 2.2 — Apple Silicon DMG

## Português

[Baixar e ver o guia no site](https://www.voigtcore.com.br/downloads/2.2.0/macos-silicon.html?lang=pt-BR).

1. Baixe o arquivo `.dmg` e confira o SHA-256.
2. Abra o disco e o aplicativo **VCore Pulse**.
3. Clique em **Instalar e abrir Pulse**. Quando o serviço estiver pronto, o painel abre no navegador.
4. Se solicitado, autorize o Acesso às Chaves do macOS.
5. Ejete o disco após concluir. O aplicativo fica em `~/Applications/VCore Pulse.app`; o serviço inicia ao entrar na conta.

Atualize sem usar removedor. Faça backup pelo Pulse e preserve os dados e as chaves.

O pacote ainda não tem assinatura Developer ID nem notarização Apple. Siga a [orientação oficial da Apple](https://support.apple.com/102445) para aprovação individual, quando permitida pela política do Mac. Não desative o Gatekeeper. Montar o DMG não executa o aplicativo automaticamente.

## English

[Download and installation guide](https://www.voigtcore.com.br/downloads/2.2.0/macos-silicon.html?lang=en).

1. Download the `.dmg` and verify its SHA-256.
2. Open the disk and **VCore Pulse** app.
3. Choose **Install and open Pulse**. The browser dashboard opens when the service is ready.
4. Approve macOS Keychain access if requested.
5. Eject the disk when finished. Reopen from `~/Applications/VCore Pulse.app`; the service starts at login.

Back up through Pulse before updating. Preserve keys and data; do not uninstall first.

Not yet Developer ID signed or Apple-notarized. Follow [Apple's per-app approval instructions](https://support.apple.com/102445) where your Mac policy permits. Do not disable Gatekeeper. Mounting the DMG does not automatically execute the application.

## Validation / Validação

Build 20; visual wrapper 20.1; ARM64. Built and tested on macOS 14.

- DMG integrity, mount, bundle integrity and mounted installer: PASS.
- Native runtime, encrypted database, reinstall preservation, restart, PDF in five languages, rotation/compression and tamper rejection: PASS.
- GUI interaction, system Keychain and login startup: pending manual acceptance on a user's Mac.
- Compression keeps original archives; encrypted data may not shrink. No automatic disk space reclamation is claimed.
- Existing Windows installer unchanged.

[Automated evidence](https://github.com/VoigtCore/VCore-PULSE/actions/runs/36589598794).

SHA-256: `201170c95fe54c9a15163c007f4838e08dad8455df2bc509a3ce219dfa562e35`.

Support: suporte@voigtcore.com.br
