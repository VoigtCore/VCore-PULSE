import Cocoa

final class Launcher: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var button: NSButton!
    var status: NSTextField!
    let translations: [String: [String: String]] = {
        guard let url = Bundle.main.url(forResource: "translations", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let result = try? JSONDecoder().decode([String: [String: String]].self, from: data) else { return [:] }
        return result
    }()
    var language: String {
        let locale = Locale.preferredLanguages.first ?? "en"
        if locale.hasPrefix("pt") { return "pt-BR" }
        if locale.hasPrefix("es") { return "es" }
        if locale.hasPrefix("zh") { return locale.contains("Hant") || locale.contains("TW") || locale.contains("HK") ? "zh-Hant" : "zh-Hans" }
        return "en"
    }
    var architecture: String {
        #if arch(arm64)
        return "Apple Silicon"
        #else
        return "Intel"
        #endif
    }
    var busy = false
    func text(_ key: String) -> String { translations[language]?[key] ?? translations["en"]?[key] ?? key }
    func applicationDidFinishLaunching(_ notification: Notification) {
        window = NSWindow(contentRect: NSRect(x: 0,y: 0,width: 580,height: 390),styleMask: [.titled,.closable,.miniaturizable],backing: .buffered,defer: false)
        window.title = "VCore Pulse 2.2 · \(architecture)"
        window.center()
        let view = window.contentView!
        let icon = NSImageView(frame: NSRect(x: 34,y: 280,width: 76,height: 76))
        icon.image = NSImage(named: NSImage.Name("AppIcon")); view.addSubview(icon)
        let title = NSTextField(labelWithString: "VCore Pulse 2.2")
        title.font = .systemFont(ofSize: 30,weight: .bold);title.frame = NSRect(x: 130,y: 306,width: 410,height: 40);view.addSubview(title)
        let subtitle = NSTextField(labelWithString: text("subtitle") + " · " + architecture)
        subtitle.textColor = .secondaryLabelColor;subtitle.frame = NSRect(x: 132,y: 281,width: 410,height: 24);view.addSubview(subtitle)
        let body = NSTextField(wrappingLabelWithString: text("body"))
        body.frame = NSRect(x: 36,y: 128,width: 508,height: 135);body.font = .systemFont(ofSize: 14);view.addSubview(body)
        status = NSTextField(wrappingLabelWithString: text("warning"))
        status.font = .systemFont(ofSize: 12);status.textColor = .secondaryLabelColor;status.frame = NSRect(x: 36,y: 66,width: 508,height: 48);view.addSubview(status)
        button = NSButton(title: text("install"),target: self,action: #selector(run))
        button.bezelStyle = .rounded;button.keyEquivalent = "\r";button.frame = NSRect(x: 292,y: 20,width: 252,height: 36);view.addSubview(button)
        window.makeKeyAndOrderFront(nil);NSApp.activate(ignoringOtherApps: true)
    }
    @objc func run() {
        if busy { return };busy = true;button.isEnabled = false
        status.stringValue = text("working")
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
                self.status.stringValue = code == 0 ? self.text("success") : self.text("failure").replacingOccurrences(of: "{code}", with: String(code))
                self.button.title = self.text("open")
            }
        }
    }
    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply { busy ? .terminateCancel : .terminateNow }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { !busy }
}
let app = NSApplication.shared
app.setActivationPolicy(.regular)
let delegate = Launcher();app.delegate = delegate;app.run()
