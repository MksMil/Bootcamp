//
//  EnvWorks.swift
//  Bootcamp
//
//  Created by Миляев Максим on 07.03.2024.
//

import SwiftUI

struct EnvWorks: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .environment(\.font, Font.headline)
        
    }
}

#Preview {
    EnvWorks()
}
