# Pulse 2.2 — plataformas / platforms

Build **2026.09.29-release-candidate.19**, base congelada / frozen base.

| Plataforma / Platform | Validação executada / Completed validation | Pendente / Pending |
|---|---|---|
| Windows 10/11 x64 | Windows 10: upgrade de schema legado, identidade, licença, histórico e criptografia preservados / legacy upgrade and preservation PASS | Novo build no notebook Windows 11 / this build on the Windows 11 notebook; Authenticode |
| Linux x64 | Ubuntu 22.04 x64 — PASS | Aceitação manual, Secret Service, reboot/serviço e carga / manual acceptance, OS vault, reboot/service and load |
| Linux ARM64 | Ubuntu 24.04 ARM64 — PASS | Mesmos ensaios; não suporta ARM32 ou musl/Alpine / same acceptance work; no ARM32 or musl/Alpine |
| macOS Intel | macOS 15 Intel — PASS | Keychain, LaunchAgent/reboot, hardware e notarização / OS vault, service/reboot, hardware and notarization |
| macOS Apple Silicon | macOS 14 ARM64 — PASS | Mesmos ensaios / same acceptance work |
| Windows ARM64 | Não entregue / Not delivered | Próxima expansão / next extension |

[Execução dos quatro pacotes / Four-package run](https://github.com/VoigtCore/VCore-PULSE/actions/runs/36562683046) · [Evidências / Evidence](evidence/pulse-2.2-build19.json)

Os ensaios Unix verificam instalação, saúde, SQLCipher, recusa de origem indevida, PDF em cinco idiomas, encerramento, reinstalação preservando o banco, reinício com identidade e histórico e recusa de manifesto adulterado. Usam chaves externas descartáveis e Commerce desabilitado; não efetuam compras reais.

Unix tests cover installation, health, SQLCipher, hostile-origin rejection, five-language PDF, shutdown, database-preserving reinstall, restart with identity/history and tampered-manifest rejection. They use disposable external keys with Commerce disabled; no real purchases are made.

O responsável confirmou compras Pix e cartão internacional na base anterior. Nesta entrega, 41 testes focados do Pulse, 52 do Commerce e 120 estados de interface/24 compras simuladas passaram. Essas evidências não substituem ensaio bancário real de cada plataforma.

The owner confirmed Pix and international-card purchases on the previous base. This delivery passed 41 focused Pulse tests, 52 Commerce tests and 120 UI states/24 simulated purchases. These do not replace real bank testing per platform.

Motores, cliente de pagamentos, licenciamento e banco do Windows permanecem byte a byte iguais ao v18. Unix mantém o adaptador de plataforma validado e a tradução previamente autorizada de um título do relatório. / Windows engines, payment client, licensing and database code are byte-identical to v18. Unix retains the validated platform adapter and previously authorized report-title translation.

Sem assinatura de distribuição/notarização; sem atualização automática. Linux headless mantém SQLCipher com arquivos de chave protegidos por permissões; isso não equivale a cofre criptografado. / No distribution signing/notarization or automatic updates. Headless Linux uses SQLCipher with permission-protected key files, not an encrypted OS vault.

FreeBSD e Unix enterprise não têm instaladores nesta entrega. / No FreeBSD or enterprise Unix installers in this delivery.
