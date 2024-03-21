//
//  MatchGeoEffect.swift
//  Bootcamp
//
//  Created by Миляев Максим on 08.03.2024.
//

import SwiftUI

struct MatchGeoEffect: View {
    
    @State private var isSource: Bool = true
    @State private var selected = false
    
    let tabs = [
        Text("First"),
        Text("Second"),
        Text("Third"),
        Text("Fours")
    ]
    @State private var selectedTab = 0
    @Namespace var ns
    
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            
            VStack {
                
                Rectangle()
                    .fill(Color.red)
                    .rotationEffect(.degrees(45))
                    .clipped()
                    .frame(width: 100, height: 100)
                
                Spacer()
                
                HStack {
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 100, height: 100)
                        .matchedGeometryEffect(id: "ID", in: ns, isSource: isSource)
                        .border(Color.red, width: 3)
                    Circle()
                        .fill(Color.gray)
                        .matchedGeometryEffect(id: "ID", in: ns, properties: .frame, anchor: .center, isSource: !isSource)
                        .border(Color.green,width: 3)
                }
                .animation(.easeIn(duration: 0.3), value: isSource)
                .frame(width: 300, height: 100)
//                .border(Color.black,width: 1)
                
                Toggle("Toggle Source", isOn: $isSource)
                    .padding(.horizontal)
                    .background {
                        RoundedRectangle(cornerRadius: 5).fill(Color.yellow)
                    }
                    .padding(.horizontal)
                
                Spacer()
                
                VStack(spacing: 8){
                    
                    Circle()
                        .fill(.indigo)
                        .matchedGeometryEffect(id: "source", in: ns, properties: .frame,isSource: true)
                        .border(Color.black, width: 2)

                    Rectangle()
                        .fill(.red.opacity(0.5))
                        .matchedGeometryEffect(id: "source", in: ns, properties: .frame,anchor: .bottomLeading,isSource: false)
                        .border(Color.black, width: 2)
                        .offset(x:50)
                        .offset(y:-83)

                    Circle()
                        .fill(.green)
                        .matchedGeometryEffect(id: "source", in: ns, properties: .frame,anchor: .topLeading,isSource: false)
                        .border(Color.black, width: 2)
                    
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.blue)
                        .matchedGeometryEffect(id: "source", in: ns, properties: .frame,anchor: .topTrailing,isSource: false)
                        .border(Color.black, width: 2)
                    Circle().fill(.gray)
                    Button(action: {
                        withAnimation(.linear(duration: 5)){
                            self.selected.toggle()
                        }
                    }) {
                    RoundedRectangle(cornerRadius: 10)
                    .fill(selected ? Color.red : .green)
//                    .animation(nil,value: selected)
                    .frame(width: selected ? 100 : 50, height: 50)
                    .rotationEffect(Angle.degrees(selected ? 45 : 0))
                    }
//                    .animation(.linear(duration: 5),value: selected)

                }
                .frame(height: 407)
                .border(.red, width: 2)
                
                
                Spacer()
                
                // CustomTab
                HStack{
                    ForEach(tabs.indices, id: \.self) { tabIndex in
                        Button(action: {
                            withAnimation {
                                self.selectedTab = tabIndex
                            }
                        }, label: {
                            tabs[tabIndex]
                                .lineLimit(1)
                                .padding()
                                
                        })
                        //data about geometry added to tabIndex Id in ns namespace
                        .matchedGeometryEffect(id: tabIndex, in: ns)
                    }
                }
                .padding(.horizontal)
                .overlay {
                    Rectangle()
                        .fill(Color.accentColor)
                        .padding(.horizontal)
                        .frame(height: 2, alignment: .bottom)
                        .offset(y: -10)
                    //receives data about geometry from ns namespaces by selectedtab Id and apply to line
                        .matchedGeometryEffect(id: selectedTab, in: ns, isSource: false)
                }
//                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.ultraThinMaterial)
                    //receives data about geometry from ns namespaces by selectedtab Id and apply to rect
                        .matchedGeometryEffect(id: selectedTab, in: ns, isSource: false)
                }
            }
        }
    }
}

#Preview {
    MatchGeoEffect()
}
