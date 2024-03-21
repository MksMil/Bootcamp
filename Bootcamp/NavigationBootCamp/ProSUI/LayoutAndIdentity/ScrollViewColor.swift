//
//  ScrollViewColor.swift
//  Bootcamp
//
//  Created by Миляев Максим on 11.03.2024.
//

import SwiftUI

struct ScrollViewColor: View {
    var body: some View {
        ScrollView {
            Color.red
                .frame(minWidth: nil, idealWidth: nil, maxWidth: 100, minHeight: nil, idealHeight: 400, maxHeight: nil)
                .frame(width: 200, height: 400)
                .background(.blue)
            Text("Hello world!")
                .frame(width: 200, height: 200)
                .background(.blue)
                .frame(width: 300, height: 300)
                .background(.red)     
        }
    }
}

#Preview {
    ScrollViewColor()
}
