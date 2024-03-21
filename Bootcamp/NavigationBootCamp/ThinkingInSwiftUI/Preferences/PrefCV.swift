//
//  PrefCV.swift
//  Bootcamp
//
//  Created by Миляев Максим on 08.03.2024.
//

import SwiftUI

struct MyNavigationTitleKey: PreferenceKey {
    static var defaultValue: String? = nil
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = value ?? nextValue()
    }
}

extension View {
    func myNavigationTitle(_ title: String) -> some View {
        self.preference(key: MyNavigationTitleKey.self, value: title)
    }
}

struct MyBackCol: PreferenceKey{
    static var defaultValue: Color? = nil
    
    static func reduce(value: inout Color?, nextValue: () -> Color?) {
        value = value ?? nextValue()
    }
}

extension View {
    func myBackCol(_ color: Color) -> some View{
        self.preference(key: MyBackCol.self, value: color)
    }
}

struct MyNavigationView<Content>: View where Content: View {
    let content: Content
    
    @State private var title: String?
    @State private var bkCol: Color?
    
    var body: some View {
        ZStack{
            if let bkCol{
                bkCol
                    .ignoresSafeArea()
            }
            VStack(spacing: 12) {
                Text(title ?? "View Title lost")
                    .font(Font.largeTitle)
                    .padding(.horizontal)
                    .background(.ultraThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                content
                    .padding(.horizontal)
                    .padding(.vertical,12)
                    .background {
                        RoundedRectangle(cornerRadius: 5).fill(.regularMaterial)
                    }
                    .onPreferenceChange(MyNavigationTitleKey.self) { self.title = $0 }
                    .onPreferenceChange(MyBackCol.self) { self.bkCol = $0 }
            }
        }
    }
}

struct PrefCV: View {
    @State var number: Int = 10
    
    var body: some View {
        MyNavigationView(
            content:
                VStack(alignment: .leading, spacing: 10){
                    Text("Hello")
                    Text("Hello")
                    Text("Hello")
                    Text("Hello my dear friend")
                }
                .font(.headline)
                .myNavigationTitle("Root View asasdas")
                .myBackCol(Color.red)
            
        )
    }
}

#Preview {
    PrefCV()
}
