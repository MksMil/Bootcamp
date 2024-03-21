//
//  ColapsableHStack.swift
//  Bootcamp
//
//  Created by Миляев Максим on 09.03.2024.
//

import SwiftUI

import SwiftUI

struct Collapsible<Element, Content: View>: View {
    var data: [Element]
    var expanded: Bool = false
    var spacing: CGFloat? = 8
    var alignment: VerticalAlignment = .center
    var collapsedWidth: CGFloat = 10
    var content: (Element) -> Content
    
    func child(at index: Int) -> some View {
        let showExpanded = expanded || index == self.data.endIndex - 1
        return content(data[index])
            .frame(width: showExpanded ? nil : collapsedWidth,
                   alignment: Alignment(horizontal: .leading, vertical: alignment))
    }
    
    var body: some View {
        HStack(alignment: alignment, spacing: expanded ? spacing : 0) {
            ForEach(data.indices, id: \.self, content: { self.child(at: $0) })
        }
    }
}

struct ColapsableHStack: View {
    let colors: [(Color, CGFloat)] = [(.init(white: 0.3), 50),
                                      (.init(white: 0.8), 30),
                                      (.init(white: 0.5), 75),
                                      (.init(white: 0.3), 50),
                                      (.init(white: 0.8), 30),
                                      (.init(white: 0.5), 75)]
    @State var expanded: Bool = true
    
    var body: some View {
        VStack {
            Collapsible(data: colors, expanded: expanded) { (item: (Color, CGFloat)) in
                Rectangle()
                    .fill(item.0)
                    .frame(width: item.1, height: item.1)
            }
            .border(Color.black, width: 2)
            Button(action: { withAnimation(.default) {
                self.expanded.toggle() } }, label: {
                    Text(self.expanded ? "Collapse" : "Expand")
                })
            VStack(alignment: .leading, spacing: expanded ? 10:0){
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 100)
                    .frame(width: 100)
                Rectangle()
                    .fill(Color.red)
                    .frame(height: 100)
                    .frame(width: expanded ? nil :  100)
            }
            .border(Color.black, width: 3)
        }
    }
}

#Preview {
    ColapsableHStack()
}
