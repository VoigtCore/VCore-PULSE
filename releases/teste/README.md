# VCore Pulse 2.2 — candidato para testes de engenharia

Build: `2026.09.23-pulse-evolution` · Windows 10/11 x64. Revisão: `commerce-urgent-20260924`.

[Baixar instalador de teste](https://github.com/VoigtCore/VCore-PULSE/raw/refs/heads/main/releases/teste/VCorePulse2.2.0-windows-x64.exe)

Este arquivo substitui o instalador anterior desta pasta. É um candidato **sem assinatura Authenticode**, destinado à avaliação pelos engenheiros. Não é a publicação comercial definitiva nem um pacote do canal de atualização automática. A versão anterior permanece recuperável no histórico do Git.

## Correções desta revisão

- O painel público em `/pulse/` reconhece o checkout público mesmo quando o build não informa a opção adicional. Isso evita usar a identidade de licença do servidor para uma compra do visitante.
- No aplicativo instalado, a ação “Já paguei · verificar agora” solicita uma consulta ao Commerce. A consulta automática continua usando o endpoint de status; a ação manual não depende apenas do estado em cache.
- Preservados os acabamentos do Instantâneo, os cinco idiomas e os gráficos com quatro indicadores, cursor comparativo, candles e detalhamento por hora.
- Mantidos o instalador, o runtime Node, o schema 10 e os componentes de identidade e continuidade. No backend empacotado, somente `pulse/http-handler.js` mudou em relação ao candidato anterior.

## Verificado nesta entrega

- **23/23 testes direcionados:** 18 do fluxo de checkout/atualização de licença e 5 do manifesto e integridade de distribuição. ESLint e builds aprovados.
- Consulta manual real da licença local: HTTP 200 em 1.906 ms, Commerce conectado, cartão/Pix/boleto disponíveis na resposta e identidade/prazo preservados.
- Checkout público: preparação sem os dados obrigatórios retorna HTTP 422; origem externa recusada com HTTP 403. Essas verificações não criaram cobrança.
- Extração/CRC do instalador e payload aprovados: 1.495 arquivos, 7/7 arquivos de frontend iguais ao build validado e 224 arquivos JS/MJS iguais à fonte conferida.
- Diferenças internas frente à revisão anterior limitadas ao frontend e ao handler HTTP autorizado. Sem bancos pessoais, certificados privados, vaults ou credenciais no pacote. O único arquivo `.env.example` é um modelo de Telegram com os campos de credenciais vazios.

Um candidato anterior passou instalação/reinstalação em perfil isolado no Windows 10 Pro 22H2, telemetria, relatórios JSON/CSV/PDF, SQLCipher e preservação de histórico, chaves e trial. Neste EXE, a validação foi de extração, integridade e paridade; **não foi repetida a instalação completa**. Windows 11 é um alvo do instalador; **a execução em uma máquina Windows 11 ainda precisa ser validada**. Não foi executada novamente a suíte completa.

## Como avaliar

1. Confira o SHA-256 antes da instalação.
2. Instale, abra o Pulse, aguarde a primeira coleta e confira os horários das leituras.
3. Use “Já paguei · verificar agora” para consultar a situação da licença; essa ação não cria uma compra.
4. Gere um relatório; encerre e abra novamente para conferir a continuidade do histórico.
5. Registre versão do Windows, horário, resultado esperado e resultado observado ao reportar um problema. Remova dados pessoais e segredos dos anexos.

O VLP permanece em modo local; transporte remoto e vínculo com VCore Server não são ativados por este pacote. A homologação fiscal não faz parte desta distribuição. Nenhuma cobrança foi criada pelos testes desta entrega.

SHA-256:

```
244b5f40d7570075914bfcdaa86009783e09514edcd72773fbfefede8932e77c
```

Tamanho: 45.271.748 bytes. O manifesto desta pasta é informativo e não contém assinatura Ed25519; não deve ser usado como manifesto de atualização automática.
