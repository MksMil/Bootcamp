//
//  PrefferencesPROSUI.swift
//  Bootcamp
//
//  Created by Миляев Максим on 19.03.2024.
//

import SwiftUI

struct PrefferencesPROSUI: View {
    
    @State private var size: Double = 0
    
    var body: some View {
        NavigationStack {
          VStack {
            Image(systemName: "sun.max")
//                  .navigationTitle("Image")
            Text("Welcome!")
                  .frame(width: size)
                  .background{RoundedRectangle(cornerRadius: 10).fill(.orange)}
              SizingView(number: 1)
              SizingView(number: 2)
              SizingView(number: 3)
                  
              Text("100%")
                  .padding(.horizontal)
                  .frame(width: size)
                  .background {
                      RoundedRectangle(cornerRadius: 10).fill(.blue)
                  }
              Text("150%")
                  .padding(.horizontal)
                  .frame(width: size * 1.5)
                  .background {
                      RoundedRectangle(cornerRadius: 10).fill(.green)
                  }
              Text("200%")
                  .padding(.horizontal)
                  .frame(width: size * 2)
                  .background {
                      RoundedRectangle(cornerRadius: 10).fill(.yellow)
                  }
          }
          .onPreferenceChange(WidthPreferenceKey.self, perform: { value in
//              print(value)
              self.size = value
          })
          .navigationTitle("Width : \(size.formatted(.number.precision(.fractionLength(0))))")
        }
    }
}

#Preview {
    PrefferencesPROSUI()
}

// MARK: - Prefference Width

struct WidthPreferenceKey: PreferenceKey{
    static let defaultValue: Double = 0
    
    static func reduce(value: inout Double, nextValue: () -> Double) {
        value = nextValue()
    }
}

struct SizingView: View {
    var number: Int
    @State private var privateWidth: Double = 100
    
    var body: some View {
        ZStack{
            Color.red
            Text("\(number)")
                .foregroundStyle(.black)
        }
            .frame(width: privateWidth, height: 100)
            .onTapGesture {
//                print("tapped \(number)")
                self.privateWidth = .random(in: 50...100)
            }
            .preference(key: WidthPreferenceKey.self, value: privateWidth)
//            .transformPreference(WidthPreferenceKey.self) { value in
//                value = privateWidth
//            }
    }
}
