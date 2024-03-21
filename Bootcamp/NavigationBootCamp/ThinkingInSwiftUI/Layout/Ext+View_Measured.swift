//
//  Ext+View_Measured.swift
//  Bootcamp
//
//  Created by Миляев Максим on 09.03.2024.
//

import SwiftUI

extension View {
    func measured(_ color: Color) -> some View {
        overlay(GeometryReader { p in
            HStack(spacing: 2) {
                Arrow()
                Text("\(p.size.width, specifier: "%.0f")")
                    .font(.system(size: 14)).bold()
                    .foregroundColor(color)
                    .fixedSize()
                    .frame(maxHeight: .infinity)
                Arrow()
                    .scaleEffect(-1, anchor: .center)
            }
        })
    }
    
    var measured: some View {
        measured(.white)
    }
    
    var measuredBelow: some View {
        self
            .padding(.bottom, 25)
            .overlay(Color.clear.frame(height: 25).measured(.black), alignment: .bottom)
    }
}

struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            let x = rect.minX + 2
            let size: CGFloat = 5
            p.move(to: CGPoint(x: x, y: rect.midY))
            p.addLine(to: CGPoint(x: x + size, y: rect.midY - size))
            p.move(to: CGPoint(x: x, y: rect.midY))
            p.addLine(to: CGPoint(x: x + size, y: rect.midY + size))
            p.move(to: CGPoint(x: x, y: rect.midY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        }
    }
}

struct Arrow: View {
    var body: some View {
        ArrowShape()
            .stroke(lineWidth: 1)
            .foregroundColor(Color(red: 9/255.0, green: 73/255.0, blue: 109/255.0))
    }
}

#Preview {
    Arrow()
}
