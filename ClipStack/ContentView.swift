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

    private let rows = [
        GridItem(.fixed(44)), // First row height
        GridItem(.fixed(44)) // Second row height
        // Add more rows as needed
    ]

    var body: some View {
        ScrollView {
            LazyHGrid(
                rows: rows,
                spacing: 16)
            {
                ForEach(clipboardMonitor.clipboardTextHistory, id: \.self) { text in Text(text)
                }.padding()
                    .frame(minWidth: 100, maxWidth: 100)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                    .onTapGesture {
                        let newText = "\(text) (\(Date()))"
                        clipboardMonitor.makeClipboardPrimary(item: newText)
                        print("Item clicked: \(newText)")
                    }
            }
        }.padding().frame(width: 500, height: 500)
    }
}

#Preview {
    ContentView().environmentObject(ClipboardMonitor.shared)
}
