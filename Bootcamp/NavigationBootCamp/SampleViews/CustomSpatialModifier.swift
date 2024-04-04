//
//  CustomSpatialModifier.swift
//  Bootcamp
//
//  Created by Миляев Максим on 27.03.2024.
//

import SwiftUI

struct CustomSpatialModifier: View {
    
    @State private var rotation: Double = 0//45
    
    var body: some View {
        ZStack{

                        Color.orange
            Color.orange
//            Text("vsfgsgdfg")
                .frame(width: 200, height: 200)
                .spatialMD(cornerRad: 10,rotation: rotation)
        }
        .ignoresSafeArea()
//        .onAppear{
//            withAnimation(.linear(duration: 12).repeatForever(autoreverses: false)) {
//                self.rotation = 360
//            }
//        }
    }
}

#Preview {
    CustomSpatialModifier()
}

struct CustomSpatial: ViewModifier{
    
    @State private var isTop = true
    
    var cornerRad: Double
    var rotation: Double
    
    var col1 = [Color.clear, Color.white]
    var col2 = [Color.white, Color.clear]
    
    var col3 = [Color.black, Color.clear]
    var col4 = [Color.clear, Color.black]
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: cornerRad))
            .overlay {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRad)
                        .stroke(Color.black, lineWidth: 2)
                        .blur(radius: 0.5)
                        .offset(x: isTop ? 1: -1, y: isTop ? 1: -1)
                        .mask(RoundedRectangle(cornerRadius: cornerRad)
                            .fill(LinearGradient(colors:[Color.black, Color.clear],
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                                .rotationEffect(Angle(degrees: rotation)))

                    RoundedRectangle(cornerRadius: cornerRad)
                        .stroke(Color.black, lineWidth: 6)
                        .blur(radius: 3)
                        .offset(x: isTop ? 3: -3, y: isTop ? 3: -3)
                        .mask(RoundedRectangle(cornerRadius: cornerRad)
                            .fill(LinearGradient(colors: isTop ? col3: col4,
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                                .rotationEffect(Angle(degrees: rotation)))

                    RoundedRectangle(cornerRadius: cornerRad)
                        .stroke(Color.white, lineWidth: 2)
                        .blur(radius: 0.5)
                        .offset(x: isTop ? -1: 1, y: isTop ? -1: 1)
                        .mask(RoundedRectangle(cornerRadius: cornerRad)
                            .fill(LinearGradient(colors: isTop ? col1 : col2,
                                                 startPoint: .top,
                                                 endPoint: .bottom))
                                .rotationEffect(Angle(degrees: rotation)))

                    RoundedRectangle(cornerRadius: cornerRad)
                        .stroke(Color.white, lineWidth: 6)
                        .blur(radius: 3)
                        .offset(x: isTop ? -3: 3, y: isTop ? -3: 3)
                        .mask(RoundedRectangle(cornerRadius: cornerRad)
                            .fill(LinearGradient(colors: isTop ? col1 : col2,
                                                 startPoint: .top ,
                                                 endPoint: .bottom))
                                .rotationEffect(Angle(degrees: rotation)))

                }
//                .opacity(0.2)
            }
            .onAppear{
                withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                    isTop = false
                }
            }
//            .padding(2)
//            .background {
//                RoundedRectangle(cornerRadius: cornerRad)
//                    .stroke(.white.opacity(0.3), lineWidth: 2)
//                    .mask {
//                        RoundedRectangle(cornerRadius: cornerRad)
//                            .fill(AngularGradient(colors: [.clear,.clear,.clear,.clear, .white,.white,.white,.white,.white,.clear,.clear,.clear,.clear], center: .center, angle: .degrees(rotation + 90)))
//                            .blur(radius: 6)
//                    }
//            }
//            .background {
//                RoundedRectangle(cornerRadius: cornerRad)
//                    .stroke(.black.opacity(0.3), lineWidth: 2)
//                    .mask {
//                        RoundedRectangle(cornerRadius: cornerRad)
//                            .fill(AngularGradient(colors: [.clear,.clear,.clear,.clear,.clear, .white,.white,.white,.white,.white,.clear,.clear,.clear,.clear,.clear],
//                                                  center: .center,
//                                                  angle: .degrees(rotation - 90)))
//                            .blur(radius: 6)
//                    }
//            }
//            .padding(-4)
//            .overlay {
//                RoundedRectangle(cornerRadius: cornerRad)
//                    .stroke(.white.opacity(0.6), lineWidth: 6)
//                    .mask {
//                        RoundedRectangle(cornerRadius: cornerRad)
//                            .fill(AngularGradient(colors: [.clear,.clear,.clear,.clear, .white,.white,.white,.white,.white,.clear,.clear,.clear,.clear], center: .center, angle: .degrees(rotation + 90)))
//                            .blur(radius: 5)
//                    }
//                
//            }
                    
    }
}

extension View {
    func spatialMD(cornerRad: Double,rotation: Double) -> some View{
        self.modifier(CustomSpatial(cornerRad: cornerRad,rotation: rotation))
    }
}
