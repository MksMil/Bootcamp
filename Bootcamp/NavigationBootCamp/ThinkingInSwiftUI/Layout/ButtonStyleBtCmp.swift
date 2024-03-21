//
//  ButtonStyleBtCmp.swift
//  Bootcamp
//
//  Created by Миляев Максим on 09.03.2024.
//

import SwiftUI

struct CircleStyle: ButtonStyle{
    
    var foreground = Color.white
    var backgrund = Color.blue
    
    func makeBody(configuration: Configuration) -> some View {
        Circle()
            .fill(backgrund.opacity(configuration.isPressed ? 0.8 : 1))
            .overlay {
                Circle().strokeBorder(foreground).padding(3)
            }
            .overlay {
                configuration.label.foregroundStyle(foreground)
            }
            .frame(width: 75, height: 75)
    }
}



struct MyCool: ButtonStyle{
    
    @State private var width: CGFloat? = nil
   
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            Circle()
                .fill(Color.blue)
                .frame(width: width, height: width)
                .overlay(content: {
                    configuration
                        .label
                        .padding(10)
                        .background {
                            GeometryReader{ proxy in
                                Color.clear.preference(key: WidthKey.self, value: proxy.size.width)
                            }
                        }
                        .onPreferenceChange(WidthKey.self, perform: { value in
                            self.width = value
                        })
                        .foregroundStyle(Color.white)
                        .scaleEffect(configuration.isPressed ? 0.95: 1) //press animation
                        .lineLimit(1)
                })
                .opacity(configuration.isPressed ? 0.7: 1)
                .shadow(color: .black,
                        radius: configuration.isPressed ? 3 : 5,
                        x: 0,
                        y: configuration.isPressed ? 1 : 3)
            //shine animation
            Circle()
                .strokeBorder(Color.white,lineWidth: 10)
                .opacity(!configuration.isPressed ? 0 : 0.5)
                .frame(width: !configuration.isPressed ? width ?? 0 + 10 : 0)
        }
        .frame(height: width)
    }
}


struct ButtonStyleBtCmp: View {
    var body: some View {
        VStack{
            Button("TAP ME") {}.buttonStyle(MyCool())//.border(Color.black, width: 2)
                                    HStack{
                                        Button("Button 1", action: {})
                                        Button("Button 2", action: {})
                                        Button("Button 3", action: {})
                                        Button("Button 4", action: {})
                                    }.buttonStyle(MyCool())
            
                                    Button("Button") {
                        //                print("Tap")
                                    }.buttonStyle(CircleStyle())
                                        .padding()
                                    HStack{
                                        Button("bordered") {}.buttonStyle(.bordered)
                                        Button("plain") {}.buttonStyle(.plain)
                                        Button("borderedProminent") {}.buttonStyle(.borderedProminent)
                                    }.padding()
                                    HStack{
                                        Button("borderless") {}.buttonStyle(.borderless)
                                        Button("automatic") {}.buttonStyle(.automatic)
                                    }.padding()
        }
    }
}

#Preview {
    ButtonStyleBtCmp()
}
