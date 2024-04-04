//
//  KeyboardBarDemo.swift
//  Bootcamp
//
//  Created by Миляев Максим on 02.04.2024.
//

import SwiftUI

enum Field {
    case suit
    case rank
}


struct KeyboardBarDemo : View {
    @FocusState var field: Field?
    @State private var suitText = ""
    @State private var rankText = ""
    
    var body: some View {
        VStack {
            TextField("Suit", text: $suitText)
                .focused($field,equals: .suit)
            TextField("Rank", text: $rankText)
                .focused($field,equals: .rank)
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                if field == .suit {
                    Button("♣️", action: {})
                    Button("♥️", action: {})
                    Button("♠️", action: {})
                    Button("♦️", action: {})
                    Spacer()
                } else {
                    Button("👑", action: {})
                    Button("🧐", action: {})
                    Button("🍟", action: {})
                    Button("🐶", action: {
                        rankText += "🐶"
                    })
                    Spacer()
                }
//                DoneButton()
                Button("Done") {
                    field = nil
                }
            }
        }
    }
}

#Preview {
    KeyboardBarDemo()
}
