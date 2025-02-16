//
//  ItemRow.swift
//  ClipStack
//
//  Created by Kyle Erikson on 2/15/25.
//

import SwiftUI

struct ItemRow: View {
    @State private var item: String
    @EnvironmentObject var clipboardMonitor: ClipboardMonitor

    init(itemInput: String) {
        print(itemInput)
        self.item = itemInput
    }

    var body: some View {
        Text(item)
            .padding(.all)
            .frame(width: 200, height: 200)
            .background(Color.blue.opacity(0.5))
            .cornerRadius(10)
            .lineLimit(nil)
            .multilineTextAlignment(.leading)
            .clipped()
            .onTapGesture {
                let newText = "\(item) (\(Date()))"
                clipboardMonitor.makeClipboardPrimary(item: newText)
                print("Item clicked: \(newText)")
            }
    }
}

#Preview {
    ItemRow(itemInput: "Copied Item 1aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadddddddddddssssssssaaa").environmentObject(ClipboardMonitor.shared)
        .frame(width: 500, height: 300)
}
