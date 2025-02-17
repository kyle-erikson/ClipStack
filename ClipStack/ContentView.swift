//
//  ContentView.swift
//  ClipStack
//
//  Created by Kyle Erikson on 2/7/25.
//

import Carbon
import SwiftUI

struct ContentView: View {
    @State var tapCount = 0
    @EnvironmentObject var clipboardMonitor: ClipboardMonitor

    private let rows = [
        GridItem(.fixed(44)), // First row height
    ]

    var body: some View {
        ScrollView {
            LazyHGrid(
                rows: rows,
                spacing: 16)
            {
                ForEach(clipboardMonitor.clipboardTextHistory, id: \.self) { text in ItemRow(itemInput: text)
                }.padding()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(ClipboardMonitor.shared).frame(width: 1000, height: 300)
}
