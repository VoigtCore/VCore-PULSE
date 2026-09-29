import Cocoa

final class Launcher: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var button: NSButton!
    var status: NSTextField!
    let portuguese = Locale.preferredLanguages.first?.hasPrefix("pt") ?? false
    var busy = false
    func text(_ pt: String, _ en: String) -> String { portuguese ? pt : en }
    func applicationDidFinishLaunching(_ notification: Notification) {
        window = NSWindow(contentRect: NSRect(x: 0,y: 0,width: 580,height: 390),styleMask: [.titled,.closable,.miniaturizable],backing: .buffered,defer: false)
        window.title = "VCore Pulse 2.2 · Apple Silicon"
        window.center()
        let view = window.contentView!
        let icon = NSImageView(frame: NSRect(x: 34,y: 280,width: 76,height: 76))
        icon.image = NSImage(named: NSImage.Name("AppIcon")); view.addSubview(icon)
        let title = NSTextField(labelWithString: "VCore Pulse 2.2")
        title.font = .systemFont(ofSize: 30,weight: .bold);title.frame = NSRect(x: 130,y: 306,width: 410,height: 40);view.addSubview(title)
        let subtitle = NSTextField(labelWithString: text("Memória Operacional · Apple Silicon", "Operational Memory · Apple Silicon"))
        subtitle.textColor = .secondaryLabelColor;subtitle.frame = NSRect(x: 132,y: 281,width: 410,height: 24);view.addSubview(subtitle)
        let body = NSTextField(wrappingLabelWithString: text("Instale ou abra o Pulse no seu usuário. Seu histórico e sua licença serão preservados. O painel abre no navegador assim que o serviço estiver pronto.\n\nO Pulse iniciará ao entrar na sua conta do Mac. O macOS pode solicitar acesso ao Acesso às Chaves. Não é necessário usar o Terminal.", "Install or open Pulse for your user. Your history and license are preserved. The dashboard opens in your browser when the service is ready.\n\nPulse will start when you log into your Mac account. macOS may request Keychain access. No Terminal commands are needed."))
        body.frame = NSRect(x: 36,y: 128,width: 508,height: 135);body.font = .systemFont(ofSize: 14);view.addSubview(body)
        status = NSTextField(wrappingLabelWithString: text("Distribuição sem notarização Apple. Consulte o guia incluído.", "Distribution is not Apple-notarized. See the included guide."))
        status.font = .systemFont(ofSize: 12);status.textColor = .secondaryLabelColor;status.frame = NSRect(x: 36,y: 66,width: 508,height: 48);view.addSubview(status)
        button = NSButton(title: text("Instalar e abrir Pulse", "Install and open Pulse"),target: self,action: #selector(run))
        button.bezelStyle = .rounded;button.keyEquivalent = "\r";button.frame = NSRect(x: 292,y: 20,width: 252,height: 36);view.addSubview(button)
        window.makeKeyAndOrderFront(nil);NSApp.activate(ignoringOtherApps: true)
    }
    @objc func run() {
        if busy { return };busy = true;button.isEnabled = false
        status.stringValue = text("Verificando, instalando e iniciando… Aguarde.", "Verifying, installing and starting… Please wait.")
        DispatchQueue.global(qos: .userInitiated).async {
            var code: Int32 = -1
            do {
                let logs = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Library/Logs/VCore Pulse")
                try FileManager.default.createDirectory(at: logs,withIntermediateDirectories: true,attributes: [.posixPermissions: 0o700])
                let log = logs.appendingPathComponent("installer.log")
                if FileManager.default.fileExists(atPath: log.path) {
                    let attrs = try FileManager.default.attributesOfItem(atPath: log.path)
                    if attrs[.type] as? FileAttributeType == .typeSymbolicLink { throw NSError(domain: "VCore",code: 4) }
                } else { FileManager.default.createFile(atPath: log.path,contents: nil,attributes: [.posixPermissions: 0o600]) }
                let handle = try FileHandle(forWritingTo: log);defer { try? handle.close() };try handle.seekToEnd()
                let process = Process();process.executableURL = URL(fileURLWithPath: "/bin/bash")
                process.arguments = [Bundle.main.resourceURL!.appendingPathComponent("install-and-open.sh").path]
                process.standardOutput = handle;process.standardError = handle
                try process.run();process.waitUntilExit();code = process.terminationStatus
            } catch { code = -1 }
            DispatchQueue.main.async {
                self.busy = false;self.button.isEnabled = true
                self.status.stringValue = code == 0 ? self.text("Pulse iniciado. O painel está aberto no navegador. Você pode ejetar o DMG e usar VCore Pulse em Aplicativos do seu usuário.", "Pulse started. The dashboard is open in your browser. You may eject the DMG and use VCore Pulse in your user Applications folder.") : self.text("Não foi possível concluir (código \(code)). Consulte Library/Logs/VCore Pulse/installer.log e o guia incluído. Seus dados não devem ser removidos.", "Could not complete (code \(code)). See Library/Logs/VCore Pulse/installer.log and the included guide. Do not remove your data.")
                self.button.title = self.text("Abrir Pulse", "Open Pulse")
            }
        }
    }
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply { busy ? .terminateCancel : .terminateNow }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { !busy }
}
let app = NSApplication.shared
app.setActivationPolicy(.regular)
let delegate = Launcher();app.delegate = delegate;app.run()
