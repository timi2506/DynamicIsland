import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var dynamicIslandWindow: NSPanel!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView()

        // Create a floating window
        dynamicIslandWindow = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 100),
            styleMask: [.nonactivatingPanel, .borderless],
            backing: .buffered, defer: false
        )
        dynamicIslandWindow.level = .floating
        dynamicIslandWindow.isOpaque = false
        dynamicIslandWindow.backgroundColor = .clear
        dynamicIslandWindow.isMovableByWindowBackground = true
        dynamicIslandWindow.hasShadow = true
        dynamicIslandWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]

        // Set the content view
        let hostingController = NSHostingController(rootView: contentView)
        dynamicIslandWindow.contentView = hostingController.view

        // Set initial position and make it visible
        dynamicIslandWindow.setFrame(
            NSRect(x: NSScreen.main?.frame.width ?? 0 - 300, y: NSScreen.main?.frame.height ?? 0 - 100, width: 300, height: 100),
            display: true
        )
        dynamicIslandWindow.makeKeyAndOrderFront(nil)
    }
}
