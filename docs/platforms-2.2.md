# Pulse 2.2 — build 20 / História em camadas

Atualização de 29/09/2026. / Update dated September 29, 2026.

| Plataforma / Platform | Validação / Validation |
|---|---|
| Windows 10/11 x64 | Windows 10: upgrade legado, identidade/licença/histórico preservados; dois rodízios SQLCipher, compressão SAFE e reinício / legacy upgrade, two encrypted rotations, SAFE compression and restart PASS |
| Linux x64 | Ubuntu 22.04 native PASS |
| Linux ARM64 | Ubuntu 24.04 ARM64 native PASS |
| macOS Intel | macOS 15 Intel native PASS |
| macOS Apple Silicon | macOS 14 ARM64 native PASS |

[Testes nativos / Native tests](https://github.com/VoigtCore/VCore-PULSE/actions/runs/36584316085) · [Evidências / Evidence](evidence/pulse-2.2-build20.json)

## Português

Corrige consultas de históricos grandes e o registro do banco de destino usado pelo contador de rodízios. A automação padrão permanece habilitada; uma configuração explícita `monitor-only` do operador continua respeitada. O limiar normal não mudou: preparação a partir de 5 GiB, limite de 6 GiB ou 90 dias; verificação a cada 15 minutos. Compressão de até um histórico elegível por ciclo de 12 horas.

Atualize executando o instalador no mesmo usuário, sem removedor. Faça backup pelo Pulse e preserve dados e chaves. Rodízio zero em uma instalação pequena ou recente é normal: a operação acontece quando os limites exigem e espaço/integridade permitem. Confira “História em camadas” após iniciar.

SAFE preserva os originais. Não há liberação automática de espaço. Bancos SQLCipher já cifrados geralmente não têm redução relevante com compressão e podem gerar um arquivo ligeiramente maior. O ganho principal do rodízio é separar o banco ativo do histórico, mantendo consultas e continuidade. Não confunda com backup externo.

Os testes Unix incluem instalação/reinstalação, SQLCipher, rodízio real com limiar reduzido apenas na amostra descartável, identidade/licença/histórico, compressão, leitura de 420 mil linhas, reinício após rodízio, PDF em cinco idiomas e recusa de manifesto adulterado. As chaves são descartáveis; o Commerce fica desabilitado durante o teste. 67 testes locais direcionados também passaram. Código de compras, licença e motores permanece idêntico ao build 19.

Limites: sem Authenticode/notarização Apple; instalação manual, sem atualização automática. Reteste em hardware Windows 11, cofres Keychain/Secret Service, serviços/reboot Unix e carga prolongada continuam pendentes. Windows ARM64, BSD e Unix enterprise não estão nesta entrega. Não houve nova compra bancária real nesta rodada.

## English

Fixes large historical queries and the destination database metadata used by the completed-rotation counter. Default automation remains enabled; an explicit operator `monitor-only` setting is respected. Normal thresholds remain unchanged: preparation from 5 GiB, 6 GiB or 90-day limit; checks every 15 minutes. Compression handles at most one eligible archive per 12-hour cycle.

Run the installer as the same user without uninstalling. Back up with Pulse and retain data and keys. Zero rotations are normal on small or recent installations. Rotation requires eligible thresholds, sufficient space and verified integrity. Check “Layered history” after startup.

SAFE retains originals and does not automatically reclaim disk space. Encrypted SQLCipher files usually do not compress meaningfully and may become slightly larger. Rotation separates active data from historical segments while preserving continuity and queries. It does not replace an external backup.

Native Unix tests cover install/reinstall, SQLCipher, real rotation with a trigger lowered only in a disposable fixture, identity/license/history preservation, compression, a 420,000-row query, post-rotation restart, five-language PDF and tampered-manifest rejection. Disposable external keys are used and Commerce is disabled. 67 focused local tests also passed. Purchase, licensing and engine code is byte-identical to build 19.

Limits: unsigned/not notarized; manual installation, no automatic application updates. Windows 11 hardware retest, Keychain/Secret Service, Unix services/reboot and sustained load remain pending. No Windows ARM64, BSD or enterprise Unix package. No new real bank purchase was performed.
