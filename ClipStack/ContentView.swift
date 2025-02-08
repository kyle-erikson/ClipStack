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

    var body: some View {
        VStack {
            Text("history")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
