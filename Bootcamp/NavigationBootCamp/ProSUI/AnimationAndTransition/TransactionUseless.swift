//
//  CustomTimingCurves.swift
//  Bootcamp
//
//  Created by Миляев Максим on 13.03.2024.
//

import SwiftUI

struct MotionAnimationModifier<V: Equatable>: ViewModifier {
    @Environment(\.accessibilityReduceMotion) var
    accessibilityReduceMotion
    let animation: Animation?
    let value: V
    func body(content: Content) -> some View {
        if accessibilityReduceMotion {
            content
        } else {
            content.animation(animation, value: value)
        } }
}

extension View {
    func motionAnimation<V: Equatable>(_ animation: Animation?,
                                       value: V) -> some View {
        self.modifier(MotionAnimationModifier(animation: animation,
                                              value: value))
    }
}

struct TransactionUseless: View {
    
    @State private var scale = 1.0
    
    var scaleValue: Double = 0.2
    
    var body: some View {
        VStack{
            VStack{
                Button("Tap Me") {
                    withMotionAnimation {
                        scale += scaleValue
                    } }
                
                .scaleEffect(scale)
                .animation(.default, value: scale)
                
                Button("Tap Me") {
                    scale += scaleValue
                }
                .scaleEffect(scale)
                .motionAnimation(.default, value: scale)
                
                Button("Tap Me") {
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        self.scale += scaleValue
                    }
                }
                .scaleEffect(scale)
                .animation(.default, value: scale)
                
                Button("Tap Me withHigh Priority") {
                    withHighPriorityAnimation(.linear(duration: 3)) {
                        scale += scaleValue
                    } }
                .scaleEffect(scale)
                .animation(.default, value: scale)
            }
            .border(Color.black, width: 1)
            .buttonStyle(.borderedProminent)
            Button("Reset") {
                scale = 1
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

func withMotionAnimation<Result>(_ animation: Animation?
                                 = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

func withoutAnimation<Result>(_ body: () throws -> Result) rethrows -> Result {
  var transaction = Transaction()
  transaction.disablesAnimations = true
  return try withTransaction(transaction, body)
}

func withHighPriorityAnimation<Result>(_ animation: Animation?
= .default, _ body: () throws -> Result) rethrows -> Result {
  var transaction = Transaction(animation: animation)
  transaction.disablesAnimations = true
  return try withTransaction(transaction, body)
}

#Preview {
    TransactionUseless()
}
