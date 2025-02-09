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
            ContentView().environmentObject(ClipboardMonitor.shared)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var clipboardMonitor: ClipboardMonitor?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Request permissions
        requestAccessibilityPermissions()

        // Start monitoring
        clipboardMonitor = ClipboardMonitor()
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
