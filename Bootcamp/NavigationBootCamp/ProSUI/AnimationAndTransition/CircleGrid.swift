//
//  CircleGrid.swift
//  Bootcamp
//
//  Created by Миляев Максим on 14.03.2024.
//

import SwiftUI

struct CircleGrid: View {
    
    var useRedFill: Bool
    
    var body: some View {
        LazyVGrid(columns: [.init(.adaptive(minimum: 64))], content: {
            ForEach(0..<30) { i in
                Circle().fill(useRedFill ? .red : .blue).frame(width: 64)
                    .transaction { transaction in
                        transaction.animation = transaction.animation?.delay(Double(i) / 10)
                    }
            }
        })
    }
}

struct ResultView: View{
    
    @State private var useRed: Bool = false
    
    var body: some View{
        CircleGrid(useRedFill: useRed)
        Spacer()
        Button("red") {
            withAnimation(.easeInOut){
                self.useRed.toggle()
            }
        }
        .buttonStyle(.borderedProminent)
        
    }
}

#Preview {
    ResultView()
}
