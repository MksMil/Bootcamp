//
//  IdentityUnderstanding.swift
//  Bootcamp
//
//  Created by Миляев Максим on 12.03.2024.
//


/// changes of id forces to rerender  view


import SwiftUI

struct Example: View {
    
    @State private var counter = 0
    var scale: Double
    
    var body: some View {
        Button("counter: \(counter)") {
            self.counter += 1
        }
        .scaleEffect(scale)
        
    }
}


struct IdentityUnderstanding: View {
    
    @State private var isScaled: Bool = false
    @State private var items = Array(1...20)
    
    var exmpleView: some View{
        if isScaled{
            Example(scale: 2)
            //                .id("example")
        } else {
            Example(scale: 1)
            //                .id("example")
        }
    }
    
    let colors: [Color] =
    [.blue, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .
     purple, .red]
    let symbols = ["run", "archery", "basketball", "bowling",
                   "dance", "golf", "hiking", "jumprope", "rugby", "tennis",
                   "volleyball", "yoga"]
    @State private var id = UUID()
    
    var body: some View {
        ZStack{
            Color.orange.ignoresSafeArea()
            
            VStack{
                exmpleView
                //                Example(scale: isScaled ? 2 : 1)
                Toggle("Scale", isOn: $isScaled.animation())
                    .padding(.horizontal)
                
                VStack(spacing: 0) {
                    List(items, id: \.self) {
                        Text("Item \($0)")
                    }
                    //                      .id(UUID())
                    .transition(.asymmetric(insertion: .move(edge: .leading),
                                            removal: .move(edge: .trailing)))
                    
                    Button("Shuffle") {
                        withAnimation(.easeInOut(duration: 1)) {
                            items.shuffle()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(5)
                    
                    VStack {
                        ZStack {
                            Circle()
                                .fill(colors.randomElement()!)
                                .padding()
                            Image(systemName: "figure.\(symbols.randomElement()!)")
                                .font(.system(size: 120))
                                .foregroundColor(.white)
                        }
                        .transition(.slide)
                        .id(id)
                        Button("Change") {
                            withAnimation(.easeInOut(duration: 1)) {
                                id = UUID() }
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.bottom)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    IdentityUnderstanding()
}
