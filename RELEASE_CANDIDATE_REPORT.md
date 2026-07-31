# VCore Pulse 2.0 RC2 — Release Candidate Report

## Identificação

- Produto: VCore Pulse
- Versão pública: 2.0.0
- Release Candidate: RC2
- Build: 2026.07.30-rc.2
- Foco: Operational Baseline Learning
- Data: 30/07/2026
- Resultado: RC2 concluída e empacotada

## Escopo preservado

A RC2 alterou somente o cálculo adaptativo da Integridade e as interpretações temporais diretamente relacionadas ao baseline. Não houve alteração de layout, arquitetura, esquema SQLite, APIs existentes, Commerce, Telegram, licenciamento ou Trial.

## Alterações realizadas

- Baseline individual para CPU, memória, disco, rede, pressão do runtime, event loop, elasticidade, entropia, resiliência e integridade histórica.
- Aprendizado feito diretamente dos históricos existentes, sem apagar ou recriar o banco.
- Confiança progressiva baseada na quantidade e no intervalo temporal das amostras.
- Níveis internos de maturidade: `LOW`, `MEDIUM` e `HIGH`.
- Peso do baseline limitado a 60%; saúde instantânea mantém pelo menos 40%.
- Com baixa confiança, o peso histórico é reduzido automaticamente.
- Distâncias são calculadas somente contra a identidade da própria máquina.
- Dispersão histórica e tolerâncias mínimas evitam penalizar oscilações normais.
- Pressão atual, persistência, mudanças bruscas, event loop, elasticidade, entropia e resiliência permanecem no cálculo.
- Eventos deduplicados de aprendizado, mudança significativa e confiança elevada na Linha da Vida.
- Narrativa executiva passou a reconhecer comportamento esperado, acima do padrão ou distante da identidade operacional.
- Constantes de composição e calibração centralizadas.
- Cache de 15 minutos para o baseline, sem novo timer, loop ou polling.

## Evidência científica

Cenário estável simulado com CPU 35%, memória 65% e disco 70%:

| Leitura | Integridade |
|---|---:|
| Modelo instantâneo absoluto | 79,2% |
| Baseline da própria máquina | 91,7% |
| Baseline de máquina normalmente leve | 70,8% |

O peso histórico medido foi de 6% com confiança baixa e 60% com confiança alta.

## Performance

Medição na memória real com banco de aproximadamente 540 MB:

- Consulta agregada do baseline: 13,27 ms.
- Variação transitória observada no heap: aproximadamente 177 KB.
- Atualização: uma vez a cada 15 minutos dentro do ciclo já existente.
- Polling adicional: nenhum.
- Loop adicional: nenhum.

## Resultado dos testes

| Teste | Resultado |
|---|---|
| ESLint | Aprovado |
| Build Vite | Aprovado |
| Calibração existente | Aprovado |
| Baseline adaptativo | Aprovado |
| Telegram | 4/4 aprovados |
| Commerce | 3/3 aprovados |
| Runtime isolado | Aprovado |
| `/api/pulse/health` | `ok` |
| Story | Gerado |
| Linha da Vida | Gerada e persistida |
| Trial | Preservado |
| Proteção de origem | 403 para origem externa |
| SQLite `integrity_check` | `ok` |
| SQLite foreign keys | Zero violações |
| SQLite journal | WAL |
| Persistência após nova abertura | Aprovada |

O grafo de dependências não foi alterado nesta RC. A última auditoria online da RC1 registrou zero vulnerabilidades; a repetição online foi bloqueada pelo ambiente de execução, sem impacto nos testes locais.

## Compatibilidade

- Banco e tabelas existentes: preservados.
- Dados históricos: preservados.
- APIs e JSON: compatíveis; somente fatores internos adicionais.
- Frontend: inalterado.
- Telegram: inalterado; eventos internos de baseline não geram notificações.
- Commerce, licença e Trial: inalterados.
- Windows e Linux: empacotados com runtime próprio.

## Artefatos RC2

| Arquivo | Tamanho | SHA-256 |
|---|---:|---|
| `VCorePulse2.0.exe` | 40.532.501 bytes | `54ad6df3106114c853141b4380f09fdacc07a5b52b332df81181de72301ad873` |
| `VCorePulse2.0.sh` | 49.878.948 bytes | `d30fe60833f74fd50334b0d0df2d9df1ec3f9a059c3797e6912e18b576c0618b` |

O manifesto foi recalculado após o empacotamento e os hashes foram conferidos diretamente nos artefatos finais.
