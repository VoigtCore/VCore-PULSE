# Limitações Conhecidas

## Public Beta

Esta versão ainda está calibrando o algoritmo de interpretação da Saúde Operacional. A RC2 já utiliza um baseline operacional adaptativo; a calibração temporal ampliada, baseada nos resultados de diferentes máquinas da Public Beta, será consolidada na próxima atualização.

## Maturidade inicial

Nas primeiras horas, o baseline possui baixa confiança e a saúde instantânea recebe maior peso. A interpretação se torna mais representativa conforme a memória temporal cresce.

## Sensores de hardware

GPU, temperatura e alguns sensores dependem do suporte oferecido pelo sistema operacional, firmware e drivers. Valores indisponíveis não significam falha do hardware.

## Linux

A Public Beta Linux é distribuída para x64 e utiliza serviço `systemd --user` quando disponível. Ambientes sem systemd podem iniciar o Pulse pelo comando local instalado.

## Assinatura do Windows

O instalador da Public Beta ainda não possui assinatura Authenticode. O SmartScreen pode solicitar confirmação manual.

## Uso diagnóstico

O Pulse oferece interpretação operacional e recomendações. Ele não substitui inspeção técnica, garantia do fabricante ou ferramentas forenses.
