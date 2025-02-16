//
//  ClipStackApp.swift
//  ClipStack
//
//  Created by Kyle Erikson on 2/7/25.
//

import Carbon
import Cocoa
import SwiftUI

@main
struct ClipStackApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ClipboardMonitor.shared)
                .background(.regularMaterial)
        }
        .windowStyle(.hiddenTitleBar)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var clipboardMonitor: ClipboardMonitor?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Request permissions
        requestAccessibilityPermissions()

        // Start monitoring
        clipboardMonitor = ClipboardMonitor()

        if let window = NSApplication.shared.windows.first {
            configureWindow(window)
        }
    }

    private func configureWindow(_ window: NSWindow) {
        // Get the main screen
        guard let screen = NSScreen.main else { return }

        // Calculate the frame for lower third
        let screenFrame = screen.visibleFrame
        let windowHeight = screenFrame.height / 3

        // Create the new frame
        let newFrame = NSRect(
            x: screenFrame.minX,
            y: screenFrame.minY,
            width: screenFrame.width,
            height: windowHeight
        )

        // Set window properties
        window.setFrame(newFrame, display: true)
        window.level = .floating // Optional: keeps window above others
        window.isMovable = false // Optional: prevents window from being moved
    }
}

// Helper function for permissions
func requestAccessibilityPermissions() {
    let trusted = AXIsProcessTrusted()
    if !trusted {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true]
        AXIsProcessTrustedWithOptions(options)
    }
}
