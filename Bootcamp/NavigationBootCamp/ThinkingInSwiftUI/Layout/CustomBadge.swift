//
//  CustomBadge.swift
//  Bootcamp
//
//  Created by Миляев Максим on 09.03.2024.
//

import SwiftUI

enum BadgeSize: CGFloat {
    case small = 16
    case medium = 24
    case large = 32
}

enum BadgeAlignment {
    case leading
    case trailing
}

struct BadgeMod: ViewModifier{
    var badgeAlignment: BadgeAlignment
    var count: Int?
    var alignment: Alignment {
        switch badgeAlignment {
        case .leading:
            return .topLeading
        case .trailing:
            return .topTrailing
        }
    }
    var color: Color
    var size: BadgeSize
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                if let count = count, count > 0 {
                    Circle().fill(color)
                        .overlay {
                            Text("\(count)").font(.caption).foregroundStyle(Color.white).scaleEffect( size.rawValue / 24)
                        }
                        .frame(width: size.rawValue,height: size.rawValue)
                        .offset(CGSize(width: alignment == .topTrailing ? size.rawValue / 3: -size.rawValue / 3,
                                       height: -size.rawValue / 3))
                }
            }
    }
}

extension View {
    func badgeModifier(_ count: Int? = nil, alignment: BadgeAlignment, color: Color, size: BadgeSize) -> some View{
        self.modifier(BadgeMod(badgeAlignment: alignment, count: count, color: color, size: size))
    }
}


struct CustomBadge: View {
    
    @State private var counter: Int = 10
    
    var body: some View {
        VStack{
            Text("Hello, World! \(counter)")
                .padding()
                .background {
                    Color.gray
                }
                .clipShape(Capsule())
                .badgeModifier(counter,alignment: .trailing, color: .red, size: .medium)
            
            HStack{
                Button("+1") {
                    withAnimation {
                        counter += 1
                    }
                }
                    Button("-1") {
                        withAnimation {
                            counter -= 1
                        }
                }
            }
        }
    }
}

#Preview {
    CustomBadge()
}
