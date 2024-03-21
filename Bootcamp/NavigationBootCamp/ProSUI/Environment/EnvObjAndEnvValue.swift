//
//  EnvObjAndEnvValue.swift
//  Bootcamp
//
//  Created by Миляев Максим on 18.03.2024.
//

import SwiftUI

// MARK: - Theme protocol
protocol Theme {
    var strokeWidth : CGFloat {get set}
    var titleFont: Font {get set}
}



struct DefaultTheme : Theme {
    var strokeWidth: CGFloat = 1.0
    var titleFont: Font = TitleFontKey.defaultValue
}

// MARK: - ThemeManager Class
class ThemeManager: ObservableObject {
    @Published var strokeWidth = 1.0
    @Published var titleFont = TitleFontKey.defaultValue
    
    @Published var activeTheme: any Theme = DefaultTheme()
    
    
    static var shared = ThemeManager()
    
    private init() {}
}

struct ThemeKey: EnvironmentKey{
    static var defaultValue: any Theme = ThemeManager.shared.activeTheme
}

extension EnvironmentValues {
    var theme: any Theme {
        get { self[ThemeKey.self]}
        set{ self[ThemeKey.self] = newValue}
    }
}
struct ThemeMod: ViewModifier{
    @ObservedObject var themeManager = ThemeManager.shared
    func body(content: Content) -> some View {
        content.environment(\.theme, themeManager.activeTheme)
    }
}

extension View {
    func themed() -> some View{
        self.modifier(ThemeMod())
    }
}


struct EnvObjAndEnvValue: View {
//    @State private var sliderValue = 1.0
//    @State private var titleFont = Font.largeTitle
    @ObservedObject var theme = ThemeManager.shared
//    @StateObject private var theme = ThemeManager.shared
    var body: some View {
        print("In Main View")
        return VStack {
            CirclesView()
                .themed()
            Text("Hello, world! \(Int(theme.activeTheme.strokeWidth))")
                .font(theme.titleFont)
            Slider(value: $theme.activeTheme.strokeWidth, in: 1...10)
            Button("Default Font") {
                theme.titleFont = .largeTitle
            }
            Button("Custom Font") {
                theme.titleFont = TitleFontKey.defaultValue
            }
        }
//        .environment(\.strokeWidth, sliderValue)
//        .environment(\.titleFont, theme.titleFont)
//        .environmentObject(theme)
    }
    
    
}

#Preview {
    EnvObjAndEnvValue()
}

// MARK: - Circles View
struct CirclesView: View {
//    @Environment(\.theme.strokeWidth) var strokeWidth
    @Environment(\.theme.strokeWidth) var themeStrokeWidth
    
    var body: some View {
        print("In CirclesView.body")
        return ForEach(0..<3) { _ in
            Circle()
                .stroke(.red, lineWidth: themeStrokeWidth)
                .overlay {
//                    Text("\(theme.strokeWidth)")
                }
        }
    }
}

// MARK: - TitleFont EK
struct TitleFontKey: EnvironmentKey{
    static var defaultValue: Font = Font.custom("Georgia", size: 34)
}

extension EnvironmentValues {
    var titleFont: Font {
        get {self[TitleFontKey.self]}
        set{self[TitleFontKey.self] = newValue}
    }
}
extension View {
    func titleFont(_ font: Font) -> some View {
        self.environment(\.titleFont, font)
    }
}



// MARK: - StrokeWidth EK
struct StrokeWidthKey: EnvironmentKey {
    static var defaultValue = 1.0
}
extension EnvironmentValues {
    var strokeWidth: Double {
        get { self[StrokeWidthKey.self] }
        set { self[StrokeWidthKey.self] = newValue }
    }
}
extension View {
    func strokeWidth(_ width: Double) -> some View {
        environment(\.strokeWidth, width)
    }
}
