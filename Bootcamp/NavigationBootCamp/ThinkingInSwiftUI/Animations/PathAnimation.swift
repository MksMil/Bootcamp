//
//  PathAnimation.swift
//  Bootcamp
//
//  Created by Миляев Максим on 11.03.2024.
//

import SwiftUI

struct PathAnimation: View {
    let sampleData: [CGFloat] = [0.1,0.3,0.6,0.4,0.8,0.7,0.2,0.9,0.4,0.7,0.1,1]
    @State var isVisible = false
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                LineGraph(data: sampleData)
                    .trim(from: 0, to: isVisible ? 1 : 0)
                    .stroke(.red, lineWidth: 6)
                    .border(.white, width: 3)
                    .aspectRatio(16 / 9, contentMode: .fit)
                    .background(.blue.opacity(0.7))
    //                .frame(width: 300, height: 200)
                
                Button("show graph") {
                    withAnimation(.linear(duration: Double(sampleData.count) / 2)) {
                        self.isVisible = true
                    }
                }
                .padding()
                .background {
                    Capsule().fill(.green)
                }
                Button("clear graph") {
                    //                withAnimation(.linear(duration: 3)) {
                    self.isVisible = false
                    //                }
                }
                .padding()
                .background {
                    Capsule().fill(.yellow)
                }
            }
        }
    }
}

#Preview {
    PathAnimation()
}

// MARK: - Line Graph Shape

struct LineGraph: Shape{
    
    let data: [CGFloat]
    
    func path(in rect: CGRect) -> Path {
        Path{ path in
            guard data.count > 1 else { return }
            let xStep = rect.width / CGFloat(data.count - 1)
            path.move(to: CGPoint(x: 0, y: rect.height * (1 - data[0])))
            for (index, point) in data.enumerated() {
                path.addLine(to: CGPoint(x: xStep * CGFloat(index), y: (1 - point) * rect.height ))
            }
            
        }
    }
    
    
}
