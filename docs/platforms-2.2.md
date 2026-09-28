# Pulse 2.2 — plataformas / platforms

Atualizado / Updated: 2026-09-28. Windows: **v16 congelado / frozen v16**. Unix: **v16-port.3**.

| Plataforma / Platform | Evidência / Evidence | Limites / Limits |
|---|---|---|
| Windows 10/11 x64 | Responsável confirmou dois PCs, Pix e compra real Wise / Owner confirmed two PCs, Pix and real Wise purchase | Mesmo EXE v16, sem Authenticode / Same v16 EXE, unsigned |
| Linux x64 | **PASS** — runner Ubuntu 22.04 x64 | Aceitação manual, serviço e cofre pendentes / Manual, service and OS-vault acceptance pending |
| Linux ARM64 | **PASS** — runner Ubuntu 24.04 ARM64 | Exige ambiente compatível com Ubuntu 24.04/glibc; Alpine/musl e ARM32 não suportados / Compatible glibc environment required; no Alpine/musl or ARM32 |
| macOS Intel | **PASS** — runner macOS 15 Intel | VM/hardware do usuário, Keychain, LaunchAgent e notarização pendentes / User VM/hardware, Keychain, LaunchAgent and notarization pending |
| macOS Apple Silicon | **PASS** — runner macOS 14 ARM64 | Mesmos limites; não implica suporte a versões antigas / Same limits; older versions not certified |
| Windows ARM64 | Não entregue / Not delivered | Próxima etapa, menor prioridade definida pelo responsável / Next step, lower owner priority |
| FreeBSD / AIX / Solaris / HP-UX / z/OS | Sem suporte anunciado / Not supported | Futuro condicionado à demanda / Demand-driven future work |

## O que passou / Passing scope

- [SQLCipher nativo nas quatro arquiteturas](https://github.com/VoigtCore/VCore-PULSE/actions/runs/36491075959): banco cifrado, chave errada recusada, reabertura e backup cifrado. / Four native targets: encrypted database, wrong-key rejection, reopen and encrypted backup.
- [Instaladores finais port.3](https://github.com/VoigtCore/VCore-PULSE/actions/runs/36496567723): instalação, painel, SQLCipher, recusa de origem indevida, PDF nos cinco idiomas, encerramento, reinstalação sem mudar o banco, reinício com identidade/histórico preservados e rejeição de manifesto adulterado. / Final packages: install, dashboard, SQLCipher, hostile-origin rejection, five-language PDFs, shutdown, database-preserving reinstall, restart with identity/history, manifest-tamper rejection.
- [Resultados JSON](evidence/pulse-2.2-port3.json). Chaves descartáveis externas; conexão Commerce desabilitada no teste. / Disposable external keys; Commerce disabled during tests.
- Windows v16 mantém SHA-256 `3354a2fdf7971240691383abfcf6cba36833b49bb9ed24f561bface93a63e0c8`.

## Alterações delimitadas / Bounded changes

Os motores, regras de licença e pagamentos permanecem congelados. Novos pacotes recebem adaptador SQLCipher por arquitetura, integração de cofre Linux, launchers, fontes Unicode e **uma tradução autorizada** do título “Hipótese de possível causa”. Os fatos armazenados e a proteção de qualidade do PDF permanecem iguais. / Engines, licensing and payments remain frozen. New packages add target-specific SQLCipher, Linux vault integration, launchers, Unicode fonts and **one approved translation** of an event title. Stored facts and PDF quality checks remain unchanged.

## Pendências reais / Remaining validation

Os testes automatizados não comprovam Keychain/Secret Service, login/reboot do serviço, estabilidade sob carga prolongada, sensores de todo hardware ou recuperação do banco de outra versão. Esses ensaios devem ser feitos nas VMs do usuário. / Automated tests do not establish OS-vault integration, service login/reboot, sustained load, every hardware sensor or cross-version database recovery. These remain user-VM acceptance work.

Distribuição sem assinatura comercial/Apple notarization. Release marcada como pré-lançamento; nenhuma atualização automática foi habilitada. / No distribution signing/Apple notarization. Release remains a prerelease; automatic updates are not enabled.

Linux headless: `--headless-key-files` conserva o banco cifrado, mas usa arquivos de chave com proteção por permissões, não um cofre criptografado. / Headless option keeps encrypted databases with permission-protected key files, not an encrypted vault.

Licenças de Node, SQLCipher, better-sqlite3, OpenSSL e fontes Noto acompanham os pacotes. / Third-party notices accompany the packages.
