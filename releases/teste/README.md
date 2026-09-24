# VCore Pulse 2.2 — candidato para testes de engenharia

Build: `2026.09.23-pulse-evolution` · Windows 10/11 x64. Revisão de interface: `ui-polish-20260923`.

[Baixar instalador de teste](https://github.com/VoigtCore/VCore-PULSE/raw/refs/heads/main/releases/teste/VCorePulse2.2.0-windows-x64.exe)

Este arquivo substitui o instalador anterior desta pasta. É um candidato **sem assinatura Authenticode**, destinado à avaliação pelos engenheiros. Não é a publicação comercial definitiva nem um pacote do canal de atualização automática. A versão anterior permanece recuperável no histórico do Git.

## Verificado nesta entrega

- Instantâneo com variação, unidade, nível de uso e horário separados, incluindo layout de celular.
- DNA e identidade dos processos traduzidos nos cinco idiomas do Pulse.
- Gráficos de quatro indicadores, minigráficos, cursor comparativo, candles e detalhamento por hora, com controle por clique, toque e teclado.
- Mesma interface aplicada no Pulse local e no painel público de Munique, preservando histórico e backend.
- 55 testes direcionados de gráficos, histórico, rede e idiomas; mais 5 testes do manifesto de distribuição. ESLint e builds aprovados.
- Extração/CRC do instalador e payload: 1.495 arquivos, 7/7 arquivos de frontend iguais ao build validado e 224 arquivos JS/MJS iguais à fonte conferida.
- Instalador, runtime, identidade e trial idênticos ao candidato anterior. Sem bancos pessoais, certificados privados, vaults ou credenciais no pacote.

O candidato anterior passou instalação/reinstalação em perfil isolado no Windows 10 Pro 22H2, telemetria, relatórios JSON/CSV/PDF, SQLCipher e preservação de histórico, chaves e trial. Neste novo EXE, a validação foi de extração, integridade e paridade; **não foi repetida a instalação completa**. Windows 11 é um alvo do instalador; **a execução em uma máquina Windows 11 ainda precisa ser validada**. Não foi executada novamente a suíte completa.

## Como avaliar

1. Confira o SHA-256 antes da instalação.
2. Instale, abra o Pulse, aguarde a primeira coleta e confira os horários das leituras.
3. Gere um relatório; encerre e abra novamente para conferir a continuidade do histórico.
4. Registre versão do Windows, horário, resultado esperado e resultado observado ao reportar um problema. Remova dados pessoais e segredos dos anexos.

O VLP permanece em modo local; transporte remoto e vínculo com VCore Server não são ativados por este pacote. A homologação fiscal não faz parte desta distribuição. Nenhuma cobrança foi criada pelos testes desta entrega.

SHA-256:

```
4d3ca87e0f5dff70151c968a020dc4588c0aeb2d06925ebe5317dfc6df64e44d
```

Tamanho: 45.271.723 bytes. O manifesto desta pasta é informativo e não contém assinatura Ed25519; não deve ser usado como manifesto de atualização automática.
