
//
//  ExploreTab.swift
//  Bootcamp
//
//  Created by Миляев Максим on 19.03.2024.
//

import SwiftUI

// MARK: - Main Content
struct ExploreTab: View {
    
    @State private var selectedCategory: Category?
    
    let categories: [Category] = [
        Category(id: "Arctic",       symbol: "snowflake"),
        Category(id: "Beach",        symbol: "beach.umbrella"),
        Category(id: "Shared Homes", symbol: "house")
    ]
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ForEach(categories) { category in
                    CategoryButton(category: category,
                                   selection: $selectedCategory)
                }
            }
            List(categories, id: \.id) { category in
                HStack {
                    Button(category.id) {
                        withAnimation {
                            selectedCategory = category
                        }
                    }
                    if selectedCategory == category {
                        Spacer()
                        Image(systemName: "checkmark")
                    }
                }
            }
            if let selectedCategory {
              Text("Selected: \(selectedCategory.id)")
                    .animation(nil, value: selectedCategory)
            }
        }
        .padding(.vertical)
        .overlayPreferenceValue(CategoryPreferenceKey.self) { preferences in
            GeometryReader { geo in
                if let selected = preferences.first(where: {$0.category == selectedCategory}) {
                    let frame = geo[selected.anchor]
                    Rectangle().fill(.red)
                        .frame(width: frame.width, height: 2)
                        .position(x: frame.midX, y: frame.maxY)
                }
                
            }
        }
        .backgroundPreferenceValue(CategoryPreferenceKey.self) { preference in
            GeometryReader{ geo in
                if let selected = preference.first(where: {$0.category == selectedCategory}){
                    let frame = geo[selected.anchor]
                    
                    RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.3))
                        .padding(-5)
                        .frame(width: frame.width, height: frame.height)
                        .position(x: frame.midX, y: frame.midY)
                }
            }
        }
        
    }
}

#Preview {
    ExploreTab()
}

// MARK: - Category Preference
struct Category: Identifiable, Equatable{
    var id: String
    var symbol: String
}

struct CategoryPreference: Equatable{
    var category: Category
    var anchor: Anchor<CGRect>
}

struct CategoryPreferenceKey: PreferenceKey{
    static let defaultValue: [CategoryPreference] = []
    
    static func reduce(value: inout [CategoryPreference],
                       nextValue: () -> [CategoryPreference]) {
        value.append(contentsOf: nextValue())
    }
    
}

// MARK: - Category Button
struct CategoryButton: View {
    var category: Category
    @Binding var selection: Category?
    var body: some View {
        Button{
            withAnimation {
                selection = category
            }
        } label: {
            VStack{
                Image(systemName: category.symbol)
                Text(category.id)
            }
        }
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityLabel(category.id)
        .anchorPreference(key: CategoryPreferenceKey.self,
                          value: .bounds,
                          transform: { anchor in
            [CategoryPreference(category: category,
                                anchor: anchor)]
        })
    }
}
