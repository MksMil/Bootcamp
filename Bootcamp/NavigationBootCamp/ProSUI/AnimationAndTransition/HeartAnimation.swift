//
//  HeartAnimation.swift
//  Bootcamp
//
//  Created by Миляев Максим on 14.03.2024.
//

import SwiftUI

// MARK: - Confetti modifier

struct ConfettiModifier<T: ShapeStyle>: ViewModifier{
    
    private let speed: Double = 0.3
    
    var color: T
    var size : Double
    
    @State private var circleSize: Double = 0.00001
    @State private var strokeMultiplier: Double = 1
    
    @State private var confettiIsHidden = true
    @State private var confettiMovement = 0.7
    @State private var confettiScale = 1.0
    
    @State private var  contentScale: Double = 0.00001
    
    func body(content: Content) -> some View {
        content
            .hidden()
            .padding(10)
            .overlay {
                ZStack{
                    GeometryReader{ geo in
                        ForEach(0..<15) { i in
                            Circle()
                                .fill(color)
                                .frame(width: size + sin(Double(i)),
                                       height: size + sin(Double(i)))
                                .scaleEffect(confettiScale)
                                .offset(x: geo.size.width / 2 * confettiMovement + (i.isMultiple(of: 2) ? size : 0))
                                .rotationEffect(.degrees(24 * Double(i)))
                                .offset(x: (geo.size.width - size) / 2,
                                        y: (geo.size.height - size) / 2)
                                .opacity(confettiIsHidden ? 0 : 1)
                        }
                        Circle()
                            .strokeBorder(color, lineWidth: geo.size.width / 2 * strokeMultiplier)
                            .scaleEffect(circleSize)
                    }
                    content
                        .scaleEffect(contentScale)
                }
            }
            .padding(-10)
            .onAppear{
                withAnimation(.easeIn(duration: speed)) {
                    circleSize = 1
                }
                withAnimation(.easeInOut(duration: speed).delay(speed / 1.5)) {
                    strokeMultiplier = 0.00001
                }
                withAnimation(.easeInOut(duration: speed).delay(speed * 1.25)) {
                    confettiIsHidden = false
                    confettiMovement = 1.2
                }
                withAnimation(.easeInOut(duration: speed).delay(speed * 2)) {
                    confettiScale = 0.00001
                }
                withAnimation(.interpolatingSpring(stiffness: 50, damping:
                                                    5).delay(speed)) {
                    contentScale = 1
                }
                
            }
    }
}

// MARK: - Transition ext
extension AnyTransition{
    
    static var confetti: AnyTransition{
        .modifier(active: ConfettiModifier(color: .blue, size: 3),
                  identity: ConfettiModifier(color: .blue, size: 3))
    }
    
    static func confetti<T: ShapeStyle>(color: T = .blue, size: Double = 3) -> AnyTransition{
        AnyTransition.modifier(active: ConfettiModifier(color: color, size: size),
                               identity: ConfettiModifier(color: color, size: size))
    }
}

// MARK: - Heart
struct HeartAnimation: View {
    
    @State private var isFavorite: Bool = false
    
    var body: some View {
        VStack(spacing: 60) {
            ForEach([Font.body, Font.largeTitle, Font.system(size: 72)], id: \.self) { font in
                Button {
                    isFavorite.toggle()
                } label: {
                    if isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .transition(.confetti(color: .red, size: 3))
                    } else {
                        Image(systemName: "heart")
                            .foregroundStyle(.gray)
                    }
                }
                .font(font)
            }
        }
        
    }
}

#Preview {
    HeartAnimation()
}
