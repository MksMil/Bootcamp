//
//  AnchorBtCmp.swift
//  Bootcamp
//
//  Created by Миляев Максим on 09.03.2024.
//

import SwiftUI

struct BoundsPreferenceKey: PreferenceKey{
    typealias Value = Anchor<CGRect>?
    static var defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = value ?? nextValue()
    }
}

struct AnchorBtCmp: View {
    
    let tabs: [String] = ["Clock", "Alarm", "Time"]
    
    @State private var selectedTabIndex = 0
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Color.green.ignoresSafeArea()
                VStack{
                    Spacer()
                    
                    HStack{
                        ForEach(tabs.indices, id: \.self) { tab in
                            Button(tabs[tab]) {
                                withAnimation(.easeIn(duration: 0.3)){
                                    self.selectedTabIndex = tab
                                }
                            }
                            // if tab selected we write to BoundsPrefKey value of selected tab's bounds
                            .anchorPreference(key: BoundsPreferenceKey.self,
                                              value: .bounds,
                                              transform: { anchor in
                                self.selectedTabIndex == tab ? anchor : nil
                            })
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    // if in BoundsPrefKey value exists - use it to draw a rect with bounds size
                    .overlayPreferenceValue(BoundsPreferenceKey.self, { anchor in
                        if let anchor = anchor {
                            GeometryReader{ geo in
                                Rectangle().fill(Color.accentColor)
                                    .frame(width: geo[anchor].width, height: 2)
                                    .offset(x: geo[anchor].minX)
                                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomLeading)
                            }
                        }
                    })
                    //                .frame(width: .infinity)
                    .padding(.bottom)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Material.regular)
                            .frame(width: geo.size.width,height: geo.size.height / 8)
                            .offset(y: 15)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    AnchorBtCmp()
}
