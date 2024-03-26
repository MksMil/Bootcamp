//
//  BackTest.swift
//  Bootcamp
//
//  Created by Миляев Максим on 26.03.2024.
//

import SwiftUI

struct BackTest: View {
    
    var content: some View{
        Text("Hello, World!")
    }
    
    var body: some View {

            content
                .background{
                    Color.red
                        .frame(width: 150, height: 150)
                }
                .frame(width: 250,height: 250)
                .background(content: {
                    Color.green
                        .overlay {
                            Color.orange
                                .frame(width: 200, height: 200)
                        }
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Image("piratCats")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                        .border(.black)
                }
    }
}

#Preview {
    BackTest()
}
