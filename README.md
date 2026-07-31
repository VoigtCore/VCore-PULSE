# VCore Pulse 2.0

![VCore Pulse — Saúde Operacional Digital](screenshots/vcore-pulse.png)

[![Status](https://img.shields.io/badge/status-Public%20Beta-f0b45a)](ROADMAP.md)
[![Version](https://img.shields.io/badge/version-2.0%20RC2-67efbc)](CHANGELOG.md)
[![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-1674cf)](#instalação)
[![Linux](https://img.shields.io/badge/Linux-x64-f5a623)](#instalação)

**Digital Operational Health**

O VCore Pulse é um Sistema de Gestão da Saúde Operacional Digital. Em vez de apresentar apenas métricas isoladas, ele interpreta a identidade, o ritmo e a trajetória temporal de cada máquina.

## Download

| Plataforma | Pacote |
|---|---|
| Windows 10/11 x64 | [Baixar VCorePulse2.0.exe](https://github.com/VoigtCore/VCore-PULSE/raw/main/releases/VCorePulse2.0.exe) |
| Linux x64 | [Baixar VCorePulse2.0.sh](https://github.com/VoigtCore/VCore-PULSE/raw/main/releases/VCorePulse2.0.sh) |

Confira a integridade dos arquivos em [SHA256SUMS.txt](releases/SHA256SUMS.txt).

## Status

### 🟡 Public Beta

Esta versão é destinada a testes públicos. Durante as próximas semanas será realizada a calibração científica contínua do algoritmo de Saúde Operacional através do Baseline Estrutural Temporal.

Feedbacks são bem-vindos em [rafael@voigtcore.com.br](mailto:rafael@voigtcore.com.br) ou nas [Issues](https://github.com/VoigtCore/VCore-PULSE/issues).

## Principais recursos

- **Integridade:** distância entre o estado atual e a identidade operacional aprendida.
- **Elasticidade:** margem disponível para absorver mudanças.
- **Resiliência:** capacidade de recuperação após impactos.
- **Entropia:** grau de variabilidade e imprevisibilidade operacional.
- **Linha da Vida:** eventos interpretados com data, hora, turno e contexto.
- **Story:** resumo executivo da trajetória da máquina.
- **Telegram:** painel remoto com estado, Story, Linha da Vida e relatórios.
- **Relatórios:** exportações PDF, CSV e JSON.
- **Diagnóstico:** pacote seguro para atendimento de suporte.
- **Trial e licenciamento:** dez dias gratuitos, ativação e renovação pelo VCore Commerce.

## Capturas

### Centro Executivo de Saúde Operacional

![Dashboard do VCore Pulse](screenshots/dashboard.png)

### Linha da Vida

![Linha da Vida](screenshots/timeline.png)

<details>
<summary>Story, Telegram e Relatórios</summary>

![Story do Dia](screenshots/story.png)

![Telegram](screenshots/telegram.png)

![Relatórios](screenshots/reports.png)

</details>

## Instalação

### Windows

1. Baixe `VCorePulse2.0.exe`.
2. Confira o SHA-256.
3. Execute o instalador e abra **VCore Pulse 2.0**.
4. A interface local será aberta em `http://127.0.0.1:4173`.

> O executável da Public Beta ainda não possui assinatura Authenticode. O Windows pode exibir um aviso do SmartScreen.

### Linux

```bash
chmod +x VCorePulse2.0.sh
./VCorePulse2.0.sh
```

O runtime necessário está incluído nos pacotes. Não é necessário instalar Node.js, npm, Git, SQLite ou Python.

## Privacidade operacional

A coleta e o aprendizado permanecem na máquina local, em `pulse.db`. O VCore Cloud é utilizado somente para serviços comerciais e de comunicação configurados pelo usuário. Consulte a [FAQ](docs/FAQ.md) e a [Arquitetura](docs/ARCHITECTURE.md).

## Documentação

- [Guia do usuário](USER_GUIDE.md)
- [Arquitetura](docs/ARCHITECTURE.md)
- [Fundação científica](docs/SCIENTIFIC_FOUNDATION.md)
- [Perguntas frequentes](docs/FAQ.md)
- [Limitações conhecidas](docs/KNOWN_LIMITATIONS.md)
- [Relatório da Release Candidate](RELEASE_CANDIDATE_REPORT.md)
- [Política de segurança](SECURITY.md)

## Licença

O VCore Pulse é software comercial proprietário disponibilizado em Public Beta. Consulte [LICENSE.md](LICENSE.md).
