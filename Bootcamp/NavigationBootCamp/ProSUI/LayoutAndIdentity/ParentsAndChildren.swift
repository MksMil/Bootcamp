//
//  ParentsAndChildren.swift
//  Bootcamp
//
//  Created by Миляев Максим on 11.03.2024.
//

import SwiftUI

struct ParentsAndChildren: View {
    @State private var usesFixedSize = false
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .fixedSize()
                .border(.blue)
                .frame(width: 300, height: 100, alignment: .bottomTrailing)
                .border(.red, width: 2)
            
            HStack {
                Text("Forecast")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(.yellow)
                Text("The rain in Spain falls mainly on the Spaniards")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(.cyan)
            }
            .fixedSize(horizontal: false, vertical: true)
            
            Text("Hello, World!")
                .border(Color.black)
                  .frame(idealWidth: 300, idealHeight: 200)
                  .border(Color.green)
                  .background(.red)
            
            VStack {
                Text("Hello, World!")
                  .frame(width: usesFixedSize ? 300 : nil)
                  .background(.red)
                Toggle("Fixed sizes", isOn: $usesFixedSize.animation())
              }
        }
    }
}

#Preview {
    ParentsAndChildren()
}
