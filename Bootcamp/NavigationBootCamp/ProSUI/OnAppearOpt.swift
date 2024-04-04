//
//  OnAppearOpt.swift
//  Bootcamp
//
//  Created by Миляев Максим on 02.04.2024.
//

import SwiftUI

struct OnAppearOpt: View {
    var body: some View {
        TabView {
            ForEach(1..<6) { i in
                ExampleView1(number: i)
                    .tabItem { Label(String(i), systemImage: "\(i).circle") }
            }
        }
    }
}

struct ExampleView1: View {
    let number: Int
    var body: some View {
        Text("View \(number)")
//            .onAppear {
//                print("View \(number) appearing")
//            }
            .onAppearOnce {
                print("View \(number) appearing")
            }
    }
}

#Preview {
    OnAppearOpt()
}

// MARK: - On Appear once modifier
struct OnAppearOnce: ViewModifier{
    
    @State var hasLoaded: Bool = false
    var perform: () -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear{
                guard !hasLoaded else { return }
                hasLoaded = true
                perform()
            }
    }
}

extension View {
    func onAppearOnce(perform: @escaping () -> Void) -> some View{
        self.modifier(OnAppearOnce(perform: perform))
    }
}
