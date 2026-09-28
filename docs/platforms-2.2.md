# Pulse 2.2 — plataformas / platforms

Atualizado / Updated: 2026-09-28. Build: `2026.09.28-release-candidate.11`.

| Alvo / Target | Estado / Status | Pendência / Remaining work |
|---|---|---|
| Windows 10/11 x64 | Candidato gerado; ensaio isolado no Windows 10 / Built candidate, isolated Windows 10 rehearsal | Assinatura de distribuição; máquina limpa Windows 11; reteste no PC afetado / Distribution signing, clean Windows 11 acceptance, affected-PC retest |
| Linux x64 | Empacotamento experimental / Experimental packaging | SQLCipher nativo e cofre no ambiente alvo, instalação, restart e rollback / Native SQLCipher and vault on target, installation, restart and rollback |
| macOS Intel x64 | Empacotamento experimental / Experimental packaging | Ensaio em Mac, assinatura/notarização, proteção e ciclo de instalação / Mac acceptance, signing/notarization, protection and installer lifecycle |
| macOS Apple Silicon ARM64 | Empacotamento experimental / Experimental packaging | Mesmas verificações em hardware ARM64 / Equivalent checks on ARM64 hardware |
| Linux ARM64 | Próxima prioridade / Next priority | Runtime, dependências nativas, sensores e aceitação / Runtime, native dependencies, sensors and acceptance |
| Windows ARM64 | Expansão posterior / Later expansion | Runtime e proteção nativos, instalador e testes / Native runtime and protection, installer and tests |
| FreeBSD | Futuro / Future | Demanda e estudo de portabilidade / Demand and portability study |
| AIX / Solaris / HP-UX / z/OS | Sem suporte anunciado / No advertised support | Demanda comercial e engenharia específica / Commercial demand and platform engineering |

## Limites / Limits

`BUILD` não equivale a `READY`. Os candidatos sem assinatura são destinados à validação local, não a instalação comercial geral. O adaptador SQLCipher empacotado nesta rodada é Windows x64; a instalação protegida Linux não deve ser declarada pronta sem esse adaptador e gestão de chave validados. Não há homologação macOS nesta máquina Windows.

`BUILD` does not mean `READY`. Unsigned candidates are for local validation, not general commercial installation. The SQLCipher adapter packaged in this iteration is Windows x64; protected Linux installation requires a validated adapter and key management. macOS acceptance cannot be claimed from this Windows host.

As capturas dos manuais são imagens reais publicadas anteriormente, usadas para orientação. Elas não provam validação multiplataforma da 2.2. / Manual screenshots are previously published real images used for orientation, not cross-platform 2.2 acceptance evidence.
