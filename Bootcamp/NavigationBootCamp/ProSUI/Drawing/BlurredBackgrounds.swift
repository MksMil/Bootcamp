//
//  BlurredBackgrounds.swift
//  Bootcamp
//
//  Created by Миляев Максим on 27.03.2024.
//

import SwiftUI

struct BlurredBackgrounds: View {
    var body: some View{
        ZStack {
            ForEach(0..<15) { _ in
                BackgroundBlob()
            }
        }
        .background(.blue)
    }
}


// MARK: - Blob
struct BackgroundBlob: View {
    @State private var rotationAmount = 0.0
    let alignment: Alignment = [.topLeading,
                                .topTrailing,
                                .bottomLeading,
                                .bottomTrailing].randomElement()!
    let color: Color = [.blue,
                        .blue,
                        .blue,
                        .cyan,
                        .indigo,
                        .mint,
                        .purple,
                        .orange,
                        .pink,
                        .red,
                        .yellow,
                        .teal].randomElement()!
    var body: some View {
        Ellipse()
            .fill(color)
            .frame(width: .random(in: 200...500),
                   height: .random(in: 200...500))
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: alignment)
            .offset(x: .random(in: -400...400),
                    y: .random(in: -400...400))
            .rotationEffect(.degrees(rotationAmount))
            .animation(.linear(duration: .random(in: 20...40)).repeatForever(),
                       value: rotationAmount)
            .onAppear {
                rotationAmount = .random(in: -360...360)
            }
            .blur(radius: 75)
    }
}

#Preview {
    BlurredBackgrounds()
}

