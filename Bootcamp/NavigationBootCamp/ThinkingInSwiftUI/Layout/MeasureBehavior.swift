//
//  MeasureBehavior.swift
//  Bootcamp
//
//  Created by Миляев Максим on 08.03.2024.
//

import SwiftUI

struct Triangle: Shape{
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: 50, y: 0))
            p.addLines([
                CGPoint(x: 100, y: 75),
                CGPoint(x: 0, y: 75),
                CGPoint(x: 50, y: 0)
            ])
        }
    }
}

struct MeasureBehavior<Content: View>: View {
    @State private var width: CGFloat = 100
    @State private var height: CGFloat = 100
    
    var content: Content
    

    var body: some View {
        VStack {
            VStack(spacing: 50){
                let image = Image(systemName: "ellipsis")
                HStack{
                    image.frame(width: 100, height: 100).border(Color.red)
                    image.resizable().frame(width: 100, height: 100).border(Color.red)
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100).border(Color.red)
                }.padding().border(Color.blue)
                
                
                Rectangle()
                    .rotation(.degrees(45))
                    .offset(x: 120)
                    .fill(Color.red)
                    .overlay{
                        Rectangle()
                            .rotation(.degrees(45))
                            .offset(x: 120)
//                            .stroke(Color.yellow, lineWidth: 8)
//                            .stroke(Color.black, lineWidth: 6)
//                            .stroke(Color.gray, lineWidth: 4)
//                            .stroke(Color.orange, lineWidth: 2)
//                            .stroke(Color.red, lineWidth: 1)
                            .padding(5)
                        //
                    }
                    .border(Color.blue)
                    .frame(width: 100, height: 100)
                    .padding()
                
                content
                    .border(Color.gray)
                    .frame(width: width, height: height)
                    .border(Color.black)
            }
            .padding()
            
            VStack(spacing: 30){
                HStack{
                    Text("Width")
                    Slider(value: $width, in: 0...500)
                }
                HStack{
                    Text("Height")
                    Slider(value: $height, in: 0...200)
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
        }
        .border(Color.red)
    }
}

struct StackView: View {
    var body: some View {
        HStack(alignment: .center,spacing: 8){
                    Text("Hello World!")//.layoutPriority(1)
                    Rectangle()
                        .fill(Color.red)
                        .frame(minWidth: 100)
                        .layoutPriority(0)
                    Rectangle()
                        .fill(Color.green)
                        .frame(minWidth: 100)
                        .layoutPriority(0)
                }
                .frame(width: 300)
//        HStack(alignment: .bottom,spacing: 0) {
//            Rectangle()
//                .fill(Color.red)
//                .frame(minWidth: 50)
//            Rectangle()
//                .fill(Color.blue)
//                .frame(maxWidth: 100)
//                .layoutPriority(1)
//        }.frame(width: 75)
            .border(Color.orange, width: 5)
    }
}


#Preview {
    MeasureBehavior(content: StackView())
}
