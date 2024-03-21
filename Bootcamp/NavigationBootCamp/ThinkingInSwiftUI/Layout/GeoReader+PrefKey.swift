//
//  GeoReader+PrefKey.swift
//  Bootcamp
//
//  Created by Миляев Максим on 09.03.2024.
//

import SwiftUI

struct WidthKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

struct GeoReader_PrefKey: View {
    
    @State private var width: CGFloat? = nil
    
    var body: some View {
        Text("Hello, World")
            .padding()
            .background {
                GeometryReader{ geo in
                    Color.clear.preference(key: WidthKey.self, value: geo.size.width)
                }
            }
            .onPreferenceChange(WidthKey.self, perform: { value in
                self.width = value
            })
            .frame(width: width, height: width)
            .background {
                Circle().fill(Color.blue)
            }
    }
}

#Preview {
    GeoReader_PrefKey()
}
