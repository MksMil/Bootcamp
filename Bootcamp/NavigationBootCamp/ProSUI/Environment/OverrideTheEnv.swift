//
//  OverrideTheEnv.swift
//  Bootcamp
//
//  Created by Миляев Максим on 19.03.2024.
//

import SwiftUI


struct WelcomeView: View {
    var body: some View {
        VStack{
            Image(systemName: "sun.max")
                .transformEnvironment(\.font) { font in
                    font = font?.weight(.black)
                }
            Text("Welcome!")
        }
    }
}


struct OverrideTheEnv: View {
    var body: some View {
        WelcomeView()
            .font(.title)
    }
}

#Preview {
    OverrideTheEnv()
}
