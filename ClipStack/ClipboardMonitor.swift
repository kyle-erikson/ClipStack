//
//  ClipboardMonitor.swift
//  ClipStack
//
//  Created by Kyle Erikson on 2/7/25.
//

import Carbon
import Cocoa
import SwiftUI

// Clipboard Monitor
class ClipboardMonitor: ObservableObject {
    private var timer: Timer?
    private var lastChangeCount: Int
    @Published var clipboardTextHistory: [String] = []
    
    static var shared = ClipboardMonitor()
    
    init() {
        lastChangeCount = NSPasteboard.general.changeCount
        print("lastChangeCount: \(lastChangeCount)")
        startMonitoring()
    }
    
    func startMonitoring() {
        print("starting to montior")
        // Monitor keyboard events globally
        NSEvent.addGlobalMonitorForEvents(matching: [.keyDown]) { event in
            // Check for Command+C (keyCode 8 is 'C')
            if event.modifierFlags.contains(.command), event.keyCode == 8 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                    self?.checkClipboard()
                }
            }
        }
        
        // Also monitor clipboard changes
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            let currentCount = NSPasteboard.general.changeCount
            if currentCount != self?.lastChangeCount {
                self?.lastChangeCount = currentCount
                self?.checkClipboard()
            }
        }
    }
    
    private func checkClipboard() {
        if let copiedString = NSPasteboard.general.string(forType: .string) {
//            print("Copied text: \(copiedString)")
            clipboardTextHistory.append(copiedString)
        }
    }
    
    func makeClipboardPrimary(item: String) {
        print("setting pasteboard")
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(item, forType: .string)
        lastChangeCount += 1
//        pasteboard.pasteboardItems?.forEach { item in
//            print("\nItem types:", item.types)
//            for type in item.types {
//                if let data = item.string(forType: type) {
//                    print("Content for type \(type):", data)
//                }
//            }
//        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
