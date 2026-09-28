# Manual do VCore Pulse 2.2

> **[Abrir o manual visual no site: capítulos, busca e imagens ampliáveis](https://www.voigtcore.com.br/manual/pulse/pt-BR/)**

🇧🇷 [Português](manual.pt-BR.md) · 🇺🇸 [English](manual.en.md) · 🇪🇸 [Español](manual.es.md) · 🇨🇳 [简体中文](manual.zh-Hans.md) · 🇹🇼 [繁體中文](manual.zh-Hant.md)

O Pulse leva **Memória Operacional** à máquina: observa recursos, relaciona acontecimentos e preserva o contexto do que mudou e de como a máquina se recuperou. O sistema operacional pode mudar; o conceito permanece.

> Edição de 28/09/2026. Apresentação do Pulse 2.2. Os downloads 2.2 ainda não estão liberados. Um pacote gerado não significa plataforma homologada. Consulte a matriz antes de instalar. Este repositório contém documentação pública, não o código privado dos motores.

## 1. Escolha o pacote certo

Baixe somente pelo [site oficial](https://www.voigtcore.com.br/#download) ou pelas [releases deste repositório](https://github.com/VoigtCore/VCore-PULSE/releases). Confira versão, plataforma e avisos do arquivo. Enquanto a 2.2 não tiver uma release aprovada, o download público anterior continua identificado pela sua própria versão.

Windows exige x64. Não instale o pacote Windows x64 em ARM64 presumindo suporte. macOS Intel e Apple Silicon usam pacotes distintos. Linux ARM64 é a próxima prioridade de expansão, não um download já homologado.

## 2. Instalação e atualização no Windows

1. Feche a janela do Pulse e execute o instalador fornecido para seu sistema.
2. Use o mesmo usuário do Windows que guarda a instalação e seus dados. A proteção local da chave depende desse usuário.
3. Aguarde a conclusão e abra **VCore Pulse 2.2** pelo atalho.
4. O painel local abre no navegador em `http://127.0.0.1:4173`. Esse endereço é da máquina onde você está, não do computador vizinho.
5. Confirme a versão apresentada, a coleta e o histórico. Uma máquina nova ainda não tem a trajetória de uma máquina observada há semanas.

Para atualizar, não apague os dados nem copie o banco de outro computador. A instalação preserva a memória, a identidade e a licença. Se houver erro, guarde o código e o `install.log` indicado na janela e contate o suporte. Não renomeie um schema nem edite o banco para contornar a verificação.

**Erro `UPDATE_INSTALL_SCHEMA_UNKNOWN`:** os builds novos corrigem a identificação de instalações legadas sem manifesto e permitem os caminhos de evolução revisados. Versões internas desconhecidas continuam bloqueadas. O reparo precisa ser validado no computador que apresentou o erro.

## 3. Entenda a primeira tela

![Painel real do Pulse; captura da edição documentada anteriormente](../screenshots/dashboard.png)

As capturas desta página são registros reais já publicados do Pulse. A apresentação da edição 2.2 pode variar; elas não constituem evidência de homologação do novo instalador.

- **Saúde operacional:** síntese do estado observado, acompanhada de contexto.
- **Resposta a mudanças e recuperação:** como a máquina reage e retorna ao seu comportamento habitual.
- **Instabilidade:** variações identificadas na observação.
- **Histórico:** idade e continuidade da memória disponível. Tempo desligado não é observação contínua.
- **Processos e recursos:** evidências de CPU, memória, disco e outros sensores disponíveis; capacidades variam por sistema.

Uma nota alta não garante ausência de falhas. O Pulse oferece evidência para análise; não substitui backup, antivírus ou decisões da equipe responsável.

## 4. Leia os gráficos e a trajetória

![Linha do tempo real do Pulse](../screenshots/timeline.png)

Os gráficos mostram a evolução das medições; observe o período, a quantidade de amostras e o contexto. Abra o histórico para relacionar mudanças, impactos e recuperações. Consulte datas e turnos disponíveis. Uma comparação sem amostras suficientes deve aparecer como indisponível, não como um fato inventado. O histórico pertence à identidade daquela máquina.

## 5. Relatórios, avisos e idioma

![Relatórios do Pulse](../screenshots/reports.png)

Escolha o período disponível para consultar ou gerar relatórios. O Pulse 2.2 evolui comparações entre períodos, resumo executivo e explicações dos episódios, aproximando os gráficos dos acontecimentos. Períodos sem amostras não comprovam funcionamento normal. Recursos de envio por e-mail exigem configuração e confirmação do destinatário. Telegram também exige configuração explícita. Consulte o estado do envio; solicitar um envio não prova entrega.

O painel oferece português, inglês, espanhol, chinês simplificado e tradicional. A mudança de idioma altera a apresentação, não a identidade ou os registros históricos.

## 6. Trial, licença e pagamento

Consulte o prazo de avaliação e as condições atuais no próprio produto. A oferta atual apresenta 10 dias de avaliação e Pulse Solo por R$ 79,90 por máquina/mês; confirme o total antes de pagar.

1. Abra **Comprar licença** ou **Renovar licença**.
2. Preencha os dados do comprador e endereço fiscal e revise plano e período.
3. Escolha **Pix** para gerar QR Code e código copia e cola. Confirme o e-mail quando solicitado e retorne ao Pulse para continuar.
4. Pague somente no aplicativo do seu banco, após conferir recebedor e valor.
5. Aguarde a confirmação ou use **Já paguei · verificar agora**. O Pulse não deve ativar a licença apenas porque exibiu um QR Code.

**Cartão:** a finalização ocorre no checkout seguro do C6. O Pulse não solicita número, validade ou CVV no painel local.

**Já iniciou cartão e quer Pix?** A interface oferece encerrar a tentativa não paga e escolher Pix. A troca depende da confirmação do banco. Uma tentativa em processamento, um timeout ou um pagamento aprovado não autoriza gerar outra cobrança automaticamente. Depois do encerramento confirmado, revise os dados e clique em **Gerar PIX**.

Quando a compra entrega a licença por e-mail, siga as instruções recebidas. A posse do computador não concede acesso a uma conta comercial de outro cliente.

## 7. Encerrar, reiniciar e preservar dados

Use a opção de encerramento do Pulse antes de manutenção. Reabra pelo atalho para retomar a observação. Não finalize processos ou remova arquivos de banco durante gravações.

O ciclo de vida do banco pode preservar períodos anteriores em arquivos administrados pelo produto. Não remova segmentos, registros de controle ou material protegido da instalação. Exportação de relatório não é backup completo. Restauração e mudança para outro usuário/computador exigem procedimento de suporte, incluindo disponibilidade das chaves.

## 8. Linux e macOS

Os scripts de instalação empacotam o runtime, mas os candidatos 2.2 ainda exigem homologação específica. O adaptador SQLCipher distribuído nesta rodada é Windows x64. Não desative a criptografia apenas para considerar o teste aprovado. Não execute scripts como root por hábito e não use um candidato para substituir uma instalação operacional sem backup e rollback verificados.

## 9. VLP e evolução do ecossistema

VLP é o caminho de integração entre componentes do ecossistema, sob identidade e permissões configuradas. Instalar o Pulse não conecta automaticamente a máquina a um VCore Server. A disponibilidade de uma integração depende da edição, configuração e validação correspondente.

Prioridades: Linux ARM64, depois Windows ARM64; FreeBSD é futuro. AIX, Solaris, HP-UX e z/OS dependem de demanda e trabalho específico. Esta lista é direção de evolução, não matriz de compatibilidade entregue.

## 10. Suporte

- Instalação e operação: [suporte@voigtcore.com.br](mailto:suporte@voigtcore.com.br).
- Licenças e compras: [comercial@voigtcore.com.br](mailto:comercial@voigtcore.com.br).
- Integrações: [engenharia@voigtcore.com.br](mailto:engenharia@voigtcore.com.br).

Informe sistema, arquitetura, versão/build, ação e código do erro. Nunca publique senhas, chaves, tokens, banco operacional ou dados completos de pagamento em uma issue. Revise os logs antes de compartilhar.
