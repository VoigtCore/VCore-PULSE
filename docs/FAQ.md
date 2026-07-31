# Perguntas Frequentes

## O Pulse envia meus dados?

A coleta e o aprendizado ficam localmente em `pulse.db`. Comunicações externas limitam-se aos serviços configurados, como licenciamento, Telegram e sincronização futura. O Pulse não envia o banco completo para realizar a coleta.

## Onde fica o banco?

- Windows: `%LOCALAPPDATA%\VoigtCore\Pulse\data\pulse.db`
- Linux: `${XDG_DATA_HOME:-~/.local/share}/vcore-pulse/data/pulse.db`

## Como funciona o Trial?

Na primeira instalação é criado um Trial de dez dias, sem cadastro obrigatório. A coleta e a memória continuam preservadas mesmo após o vencimento; somente a visualização comercial pode ser limitada.

## Como funciona o Telegram?

Abra **Telegram** no Pulse, informe o token do bot e use a descoberta automática do Chat ID. O bot oferece botões para Saúde, Linha da Vida, Story, Relatórios e Licença.

## Como ativar uma licença?

Na Home, abra **Gerenciar Licença**, informe uma chave `VPL-...` ou siga o fluxo de compra. A ativação é vinculada à identidade da máquina.

## Como gerar um relatório?

Use **Relatórios** e escolha o período de 24 horas, 7 dias ou 30 dias. Os formatos disponíveis são PDF, CSV e JSON.

## Preciso instalar Node.js ou SQLite?

Não. Os instaladores incluem o runtime necessário.

## Posso apagar ou mover a pasta do aplicativo?

Use o desinstalador. A memória fica separada da aplicação e é preservada por padrão.

## Como reportar um problema?

Abra uma [Issue](https://github.com/VoigtCore/VCore-PULSE/issues) ou envie e-mail para [rafael@voigtcore.com.br](mailto:rafael@voigtcore.com.br). Não publique tokens, chaves ou bancos completos.
