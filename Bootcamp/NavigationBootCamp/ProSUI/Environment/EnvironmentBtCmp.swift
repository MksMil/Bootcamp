//
//  EnvironmentBtCmp.swift
//  Bootcamp
//
//  Created by Миляев Максим on 14.03.2024.
//

import SwiftUI

// MARK: - Required
struct FormElementIsRequiredKey: EnvironmentKey{
    static var defaultValue = false
}

extension EnvironmentValues {
    var required: Bool {
        get { self[FormElementIsRequiredKey.self]}
        set { self[FormElementIsRequiredKey.self] = newValue}
    }
}

extension View {
    func required(_ required: Bool = true) -> some View{
        self.environment(\.required, required)
    }
}

struct RequirableTextField: View {
    
    @Binding var message: String
    @Environment(\.required) var required
    let title: String
    
    var body: some View {
        
        HStack{
            TextField(title, text: $message)
            if required {
                Image(systemName: "asterisk")
                    .imageScale(.small)
                    .foregroundStyle(.red)
            }
        }
    }
}
// MARK: - Stroked Shape
struct StrokedEnvKey: EnvironmentKey{
    static var defaultValue = false
}

extension EnvironmentValues {
    var strokedShape : Bool {
        get {self[StrokedEnvKey.self]}
        set {self[StrokedEnvKey.self] = newValue}
    }
}

struct StrokedShape<Content: Shape>:  View {
    @Environment(\.strokedShape) var strokedShape
    
    var color: Color
    var lineWidth: CGFloat
    var content: Content
    
    var body: some View{
                if strokedShape{
                    content
                        .stroke(color, lineWidth: lineWidth)
                } else {
                    content
                }

    }
}

extension View {
    func strokedShape(_ stroked: Bool = true) -> some View {
        self.environment(\.strokedShape, true)
    }
}

struct EnvironmentBtCmp: View {
    
    @State private var makeRequired: Bool = true
    @State private var firstName = ""
    @State private var lastName = ""
    
    @State private var isStroked: Bool = true
    
    var body: some View {
        VStack {
            Form{
                RequirableTextField(message: $firstName, title: "First Name")
                RequirableTextField(message: $lastName, title: "Last Name")
                Toggle("Make Required",
                       isOn: $makeRequired.animation(.easeInOut(duration: 0.3)))
                
                }
            .required(makeRequired)
            
            HStack{
                StrokedShape(color: .red, lineWidth: 2, content: Circle())
                StrokedShape(color: .orange, lineWidth: 5, content: Rectangle())
                StrokedShape(color: .blue, lineWidth: 5, content: Ellipse())
            }
            .frame(height: 100)
            .padding()
            .environment(\.strokedShape, isStroked)
            Toggle("Stroke Shapes!",
                   isOn: $isStroked.animation(.easeInOut(duration: 3)))
                .padding(.horizontal,20)
                .padding(.vertical,5)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.orange)
                }
                .padding(.horizontal,50)
        }
    }
}

#Preview {
    EnvironmentBtCmp()
}
