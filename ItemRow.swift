//
//  ItemRow.swift
//  ClipStack
//
//  Created by Kyle Erikson on 2/15/25.
//

import HighlightSwift
import SwiftUI

func isLikelyCode(_ text: String) -> Bool {
    let codePatterns = [
        // Function declarations
        #"(\b(func|def|function|void|public|private)\s+\w+\s*\([^\)]*\))"#,
        // Variable declarations
        #"(\b(var|let|const|int|string|boolean)\s+\w+\s*=)"#,
        // Common programming keywords
        #"(\b(if|else|for|while|return|class|struct|enum)\b)"#,
        // Common syntax patterns
        #"(\{[\s\S]*\})"#,
        #"(\[[\s\S]*\])"#,
        #"/<[^>]+>/)"#,
        #"/"[^"]*"/)"#,
    ]

    return codePatterns.contains { pattern in
        text.range(of: pattern, options: .regularExpression) != nil
    }
}

func isLink(_ text: String) -> Bool {
    return text.hasPrefix("http") || text.hasPrefix("https")
}

struct ItemRow: View {
    @State private var item: String
    @EnvironmentObject var clipboardMonitor: ClipboardMonitor

    init(itemInput: String) {
        print(itemInput)
        self.item = itemInput
    }

    var body: some View {
        let isCode = isLikelyCode(item)
        let isLink = isLink(item)

        if isCode {
            CodeText(item).padding().frame(width: 200, height: 200).border(.black, width: 3).cornerRadius(10)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .clipped()
                .onTapGesture {
                    let newText = "\(item) (\(Date()))"
                    clipboardMonitor.makeClipboardPrimary(item: newText)
                    print("Item clicked: \(newText)")
                }
        } else if isLink {
            Link(item,
                 destination: URL(string: item)!).padding(.all)
                .frame(width: 200, height: 200)
                .background(Color.white.opacity(0.8))
                .foregroundColor(.blue)
                .cornerRadius(10)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .clipped()
                .onTapGesture {
                    let newText = "\(item) (\(Date()))"
                    clipboardMonitor.makeClipboardPrimary(item: newText)
                    print("Item clicked: \(newText)")
                }

        } else {
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
                }.onAppear {
                    print("Is Code \(isCode)")
                    print("Is Link \(isLink)")
                }
        }
    }
}

#Preview {
    let item = """
    .onAppear {
        print("Is Code")
        print("Is Link")
    }
    """
    ItemRow(itemInput: item).environmentObject(ClipboardMonitor.shared)
        .frame(width: 500, height: 300)
}
