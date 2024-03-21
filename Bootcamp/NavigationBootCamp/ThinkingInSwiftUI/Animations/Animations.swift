//
//  Animations.swift
//  Bootcamp
//
//  Created by Миляев Максим on 11.03.2024.
//

import SwiftUI

struct Animations: View {
    
    @State private var isSelected: Bool = false
    @State private var enabled = false
    @State private var isEnabled = false
    @State private var isRect = true
    
    @Namespace var ns
    
    var body: some View {
//        VStack{
//            Button {
//                isSelected.toggle()
//            } label: {
//                Circle()
//                    .fill(isSelected ? .red: .green)
//                    .frame(width: isSelected ? 50: 100)
//                    .animation(.linear, value: isSelected)
//                    .border(Color.black, width: isSelected ? 3:1)
//                    .animation(.easeIn(duration: 3),value: isSelected)
//            }
//            
//            Button("OK") {
//                enabled.toggle()
//            }
//            .padding()
//            .frame(width: 200,height: 200)
//            .foregroundColor(.white)
//            .background(enabled ? .blue : .red)
//            .animation(.interpolatingSpring(stiffness: 100, damping: 1), value: enabled)
//            .clipShape(RoundedRectangle(cornerRadius: enabled ? 75 : 50))
//            .animation(.interpolatingSpring(stiffness: 50, damping: 2), value: enabled)
//            
//            LoadingIndicator()
//            
//            Button(isEnabled ? "Off":"ON") {
//                withAnimation(.default){
//                    self.isEnabled.toggle()
//                }
//            }
//            if isEnabled{
//                Rectangle()
//                    .fill(.blue)
//                    .frame(width: 100, height: 100)
//                    .transition(.slide.combined(with: .opacity))
//            }
            
            VStack{
                HStack {
                    if isRect {
                        Rectangle()
                            .fill(.blue)
                            .matchedGeometryEffect(id: "1", in: ns)
                            .frame(width: 200, height: 200)
                            .transition(.noOpTransition)
                    }
                    Spacer()
                    if !isRect{
                        Circle()
                            .fill(.red)
                            .matchedGeometryEffect(id: "1", in: ns)
                            .frame(width: 100,height: 100)
                            .transition(.noOpTransition)
                    }
                }
                .border(.black, width: 2)
                .frame(width: 300, height: 200)
                Toggle("Switch", isOn: $isRect)
            }
            
            .animation(.easeInOut,value: isRect)
        }
//    }
}
#Preview {
    Animations()
}
// MARK: - custom Transition with no effects

struct NoOpTransition: ViewModifier{
    var animatableData: CGFloat = 0
    
    init(x: CGFloat) {
        self.animatableData = x
    }
    func body(content: Content) -> some View {
        content
    }
}

extension AnyTransition {
    static let noOpTransition: AnyTransition = .modifier(active: NoOpTransition(x: 1),
                                                         identity: NoOpTransition(x: 0))
}


// MARK: - Loading indicator
struct LoadingIndicator: View {
    @State private var isLoading = false
    var body: some View {
        Image(systemName: "rays")
            .resizable()
            .frame(width: 20, height: 20)
            .rotationEffect(isLoading ? .degrees(360) : .zero)
            .animation(.linear(duration: 3).repeatForever(autoreverses: false), value: isLoading)
            .onAppear{ self.isLoading = true }
    }
}


