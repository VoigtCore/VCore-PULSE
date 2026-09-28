# Instalar o VCore Pulse 2.2

1. Abra a [página de downloads](https://www.voigtcore.com.br/downloads/2.2.0/).
2. Confirme sistema e processador: Windows x64; Linux x64 ou ARM64; macOS Intel ou Apple Silicon. Não instale o arquivo de outro processador.
3. Confira o SHA-256 em `SHA256SUMS.txt`. Hash é verificação de integridade, não assinatura de autoria.
4. Preserve seus dados antes de atualizar. Não apague o banco, a identidade ou as chaves. Não use um banco real em testes sem backup recuperável.

## Windows 10/11 x64

Abra `VCorePulse-2.2.0-windows-x64.exe` no usuário que utiliza o Pulse. É o mesmo v16 validado pelo responsável. O arquivo ainda não tem assinatura Authenticode. Se o Windows bloquear por política corporativa, solicite revisão ao administrador; não desative proteções do sistema.

```powershell
Get-FileHash .\VCorePulse-2.2.0-windows-x64.exe -Algorithm SHA256
```

## Linux e macOS

Os pacotes incluem Node e SQLCipher. Não é necessário instalar npm. Não use `sudo`.

```sh
# Na pasta do download; use o nome correspondente à sua plataforma.
sh VCorePulse-2.2.0-linux-x64-port3.sh
```

Linux desktop: sessão com Secret Service desbloqueado e `secret-tool` instalado. O instalador configura serviço do usuário, quando a sessão systemd está disponível. Sem sessão de serviço, execute `~/.local/opt/vcore-pulse/start-vcore-pulse.sh`.

Linux sem interface gráfica pode usar explicitamente:

```sh
sh VCorePulse-2.2.0-linux-arm64-port3.sh --headless-key-files
```

Nesse modo, o banco permanece SQLCipher e as duas chaves são criadas em `~/.config/vcore-pulse/keys`, separadas do banco, com permissões 0600. **É proteção por permissões, não cofre criptografado do sistema.** Quem obtiver os arquivos e banco poderá acessar os dados. Proteja o host e guarde as chaves junto ao procedimento de backup. Nunca publique esses arquivos.

macOS: o instalador configura um LaunchAgent no usuário; usa Keychain. O pacote não tem notarização Apple. Não desative Gatekeeper. Se bloqueado, aguarde distribuição assinada ou orientação de suporte. Início manual:

```sh
"$HOME/Library/Application Support/VCore Pulse/start-vcore-pulse.sh"
```

`--no-start` instala sem ativar serviço; útil para testes. O serviço macOS reinicia o processo enquanto estiver carregado. Para parar o serviço antes de manutenção:

```sh
# Linux
systemctl --user stop vcore-pulse.service
# macOS
launchctl bootout "gui/$(id -u)/com.voigtcore.pulse"
```

Depois de iniciar, abra `http://127.0.0.1:4173`. O painel fica local; não exponha a porta na rede. Para servidor remoto use um túnel SSH autorizado.

## Teste em sua máquina virtual

- Use VM descartável com arquitetura nativa correspondente, 4 GB de RAM e espaço livre para instalação e histórico.
- Instale, abra o painel, confirme versão, idioma e coleta de CPU/memória/disco.
- Gere relatórios nos cinco idiomas; verifique texto, gráficos e PDF.
- Encerre/reinicie e confira identidade e histórico. Reinstale mantendo dados.
- Teste início da sessão/reboot, cofre do sistema, permissões e recuperação de backup.
- Não insira cartão ou efetue cobrança para testar o instalador. O proprietário já confirmou Pix e compra com cartão no Windows; Linux/macOS ainda precisam de aceitação funcional em seu ambiente.
- Envie somente versão, sistema, etapa e erro para suporte; não envie bancos ou chaves.

O teste automatizado de instalação, painel, PDF, reinício e adulteração usa chaves descartáveis externas. **Não comprova** interação com Keychain/Secret Service, ciclo completo do serviço, sensores de todo hardware ou rollback de banco entre versões.

[Matriz](platforms-2.2.md) · [Manual visual](https://www.voigtcore.com.br/manual/pulse/pt-BR/) · suporte@voigtcore.com.br
