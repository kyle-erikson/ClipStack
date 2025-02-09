//
//  ContentView.swift
//  ClipStack
//
//  Created by Kyle Erikson on 2/7/25.
//

import Carbon
import SwiftUI

struct ContentView: View {
    @State private var text: String = "Test"
    @State var tapCount = 0
    @EnvironmentObject var clipboardMonitor: ClipboardMonitor

    var body: some View {
        VStack {
            Text("history")
            ForEach(clipboardMonitor.clipboardTextHistory, id: \.self) { item in
                Text(item)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView().environmentObject(ClipboardMonitor.shared)
}
