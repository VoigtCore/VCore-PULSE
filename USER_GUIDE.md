# VCore Pulse 2.0 — Guia rápido

Build: **2026.07.30-rc.2**

## Primeira execução

Abra **VCore Pulse 2.0**. O motor local inicia em uma janela de terminal e a interface abre em `http://127.0.0.1:4173`.

O Trial de dez dias é criado automaticamente. Nenhum login ou pagamento é necessário para começar.

## Memória

A memória fica fora da pasta do aplicativo:

- Windows: `%LOCALAPPDATA%\VoigtCore\Pulse\data\pulse.db`
- Linux: `${XDG_DATA_HOME:-~/.local/share}/vcore-pulse/data/pulse.db`

Atualizar ou desinstalar o aplicativo não remove a memória, salvo quando o usuário solicita explicitamente.

## Baseline operacional

O Pulse aprende automaticamente o comportamento habitual desta máquina. Nas primeiras horas, a confiança do baseline é baixa; ela evolui com o histórico até que a Integridade represente principalmente a distância em relação à própria identidade operacional. Utilizações recorrentes de CPU, memória, disco e rede não são comparadas com outras máquinas.

## Licença e compra

Na Home, abra **Gerenciar licença**. É possível ativar uma chave `VPL-...` ou gerar um PIX. O Pulse fala somente com o VCore Commerce; credenciais bancárias nunca ficam na máquina.

## Suporte

Use **Ajuda → Manutenção → Gerar Diagnóstico**. O ZIP omite tokens, chaves, IPs, Stories e telemetria bruta.

Contato: `rafael@voigtcore.com.br`.
