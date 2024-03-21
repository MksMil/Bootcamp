//
//  CustomAnimations.swift
//  Bootcamp
//
//  Created by Миляев Максим on 11.03.2024.
//

import SwiftUI


// MARK: - Custom animation modifier
struct Shake: Animatable, ViewModifier{
    let amplitude: CGFloat = 10
    var times: CGFloat
    var animatableData: CGFloat {
        get { times }
        set{ times = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: sin(2 * .pi * times) * amplitude)
    }
}

struct Bounce: Animatable, ViewModifier{
    let amplitude: CGFloat = 10
    var times: CGFloat
    var animatableData: CGFloat {
        get { times }
        set{ times = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .offset(y: -abs(sin(.pi * times)) * amplitude)
    }
}

extension View {
    func shake(times: Int) -> some View {
        return modifier(Shake(times: CGFloat(times)))
    }
    
    func bounce(times: Int) -> some View{
        return modifier(Bounce(times: CGFloat(times)))
    }
}

// MARK: - Custom transition
struct Blur: ViewModifier{
    var active : Bool
    
    func body(content: Content) -> some View {
        content
            .blur(radius: active ? 3 : 0)
            .opacity(active ? 0 : 1)
    }
}

extension AnyTransition{
    static var blur: AnyTransition{
        .modifier(active: Blur(active: true),
                  identity: Blur(active: false))
    }
}


struct CustomAnimations: View {
    
    @State private var taps: Int = 0
    @State private var isOn: Bool = false
    @State private var isBouce = false
    
    var body: some View {
        VStack{
            Button(action: {
                withAnimation {
                    self.taps += 1
                }
            }, label: {
                Text("Button")
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green)
                    }
            })
            .shake(times: taps * 3)
        
            Button(action: {
                withAnimation(.easeInOut(duration: 2)) {
                    self.isBouce.toggle()
                }
            }, label: {
                Text("Button")
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green)
                    }
            })
            .border(Color.black, width: 2)
            .bounce(times: isBouce ? 5 : 0)
            
            if isOn {
                Rectangle()
                    .fill(.red)
                    .frame(width: 100, height: 100)
                    .transition(.blur)
            }
            Button(isOn ? "OFF":"ON") {
                withAnimation{
                    self.isOn.toggle()
                }
            }
        }
    }
}

#Preview {
    CustomAnimations()
}
