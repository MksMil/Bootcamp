//
//  Unanimatable.swift
//  Bootcamp
//
//  Created by Миляев Максим on 13.03.2024.
//

///ProSUI curs

import SwiftUI


/// Animatable - protocol, describing how to animate property of View. 'animatableData'  property describes  data to animate
struct AnimatableZIndex: ViewModifier, Animatable{
    var zIndex: Double
    var animatableData: Double{
        get {zIndex}
        set {zIndex = newValue}
    }
    
    func body(content: Content) -> some View {
        content
            .zIndex(zIndex)
    }
}

extension View {
     func zAnimatable(value: Double) -> some View{
        self.modifier(AnimatableZIndex(zIndex: value))
    }
}

struct AnimatedNumber: View, Animatable{
    
    var value: Int = 0
    var animatableData: Double {
        get{ Double(value) }
        set{ value = Int(newValue) }
    }
    
    var body: some View{
        Text("\(value)")
    }
}

struct AnimatableMessage: View, Animatable {
    
    @Environment(\.accessibilityVoiceOverEnabled) var
    accessibilityVoiceOverEnabled
    @Environment(\.accessibilityReduceMotion) var
    accessibilityReduceMotion
    
    var message: String
    var count: Int
    
    var animatableData: Double{
        get { Double(count) }
        set { count = Int(max(0, newValue)) }
    }
    var body: some View{
        if accessibilityVoiceOverEnabled || accessibilityReduceMotion {
            Text(message)
        } else {
            let newString = message.prefix(count)
            ZStack{
                Text(message)
                    .hidden()
                    .overlay(Text(newString),
                             alignment: .leading)
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.red)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black, lineWidth: 2)
            }
        }
    }
}


struct Unanimatable: View , Animatable {
    let message = "Very very very long message!"
    @State private var counter: Int = 0
    @State private var isRedOnTop = false
    @State private var isFontScale: Bool = false
    @State private var value: Int = 0
    let colors: [Color] = [.blue,.green,.indigo,.orange,.yellow,.purple]
    
    var body: some View {
        VStack{
            Divider()
            AnimatableMessage(message: message, count: counter)
            Button("amimate text") {
                withAnimation(.linear(duration: 2)) {
                    self.counter = self.message.count
                }
            }.buttonStyle(.borderedProminent)
            Button("Cancel text") {
                withAnimation(.linear(duration: 0.2)) {
                    self.counter = 0
                }
            }.buttonStyle(.borderedProminent)
            Divider()
            
            AnimatedNumber(value: value)
            Button("animate number") {
                withAnimation(.linear(duration: 3)) {
                    self.value = Int.random(in: 1...100)
                }
            }.buttonStyle(.borderedProminent)
            Divider()
            
            Text("Text that scales")
                .font(.system(size: isFontScale ? 48:24))
            
            Button("Scaled UP") {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                    self.isFontScale.toggle()
                }
            }.buttonStyle(.borderedProminent)
            Divider()
            
            Button(isRedOnTop ? "Red to Bottom":"Red On Top") {
                withAnimation(.linear(duration: 0.3)) {
                    self.isRedOnTop.toggle()
                    
                }
            }.buttonStyle(.borderedProminent)
            
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .fill(.red)
                    .zAnimatable(value: (Double(isRedOnTop ? 6 : 0)))
                ForEach(0..<5){ i in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(colors[i])
                        .offset(x:Double(i + 1) * 20 ,y:Double(i + 1) * 5)
                        .zIndex(Double(i))
                }
            }
            .frame(width: 100, height: 100)
            
            Spacer()
            
            
        }
    }
}

#Preview {
    Unanimatable()
}
