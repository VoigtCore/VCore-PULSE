# VCore Pulse 2.2 — candidato para testes de engenharia

Build: `2026.09.23-pulse-evolution` · Windows 10/11 x64.

[Baixar instalador de teste](https://github.com/VoigtCore/VCore-PULSE/raw/refs/heads/main/releases/teste/VCorePulse2.2.0-windows-x64.exe)

Este arquivo substitui o instalador anterior desta pasta. É um candidato **sem assinatura Authenticode**, destinado à avaliação pelos engenheiros. Não é a publicação comercial definitiva nem um pacote do canal de atualização automática. A versão anterior permanece recuperável no histórico do Git.

## Verificado nesta entrega

- Instalação e reinstalação do EXE em perfil isolado no Windows 10 Pro 22H2 (build 19045).
- Runtime empacotado operacional, coleta de telemetria, Home e schema 10.
- Relatórios JSON, CSV e PDF.
- Banco SQLCipher, preservação dos bytes do banco e das chaves na reinstalação.
- Restart com preservação de identidade e histórico; alteração do nome de exibição preserva início/fim do trial.
- 19 testes direcionados de manifesto/integridade, bootstrap da identidade, continuidade do histórico e backup/restauração isolada.
- 207 arquivos JS/MJS do backend instalado idênticos ao código usado no build.

Windows 11 é um alvo do instalador; **a execução em uma máquina Windows 11 ainda precisa ser validada**. Não foi executada novamente a suíte completa.

## Como avaliar

1. Confira o SHA-256 antes da instalação.
2. Instale, abra o Pulse, aguarde a primeira coleta e confira os horários das leituras.
3. Gere um relatório; encerre e abra novamente para conferir a continuidade do histórico.
4. Registre versão do Windows, horário, resultado esperado e resultado observado ao reportar um problema. Remova dados pessoais e segredos dos anexos.

O VLP permanece em modo local; transporte remoto e vínculo com VCore Server não são ativados por este pacote. A homologação fiscal não faz parte desta distribuição. Nenhuma cobrança foi criada pelos testes desta entrega.

SHA-256:

```
1060ecf35c808f33fae683a167db4556e7954ea3143f4e17cf0e64a6abb0bbb3
```

Tamanho: 45.237.868 bytes. O manifesto desta pasta é informativo e não contém assinatura Ed25519; não deve ser usado como manifesto de atualização automática.