//
//  CustomLayout.swift
//  Bootcamp
//
//  Created by Миляев Максим on 10.03.2024.
//

import SwiftUI


struct CustomLayout: View {
    //data
    let colors: [(Color,CGFloat)] = [(.red,50), (.blue,75), (.green, 100)]
    @State var horizontal: Bool = true
    
    var body: some View {
        VStack{
            VStack{
                Button("Toggle orientation") {
                    withAnimation {
                        self.horizontal.toggle()
                    }
                }
                Stack(elements: colors,axis: horizontal ? .horizontal: .vertical) { item in
                    item.0
                        .frame(width: item.1, height: item.1)
                }
                .border(Color.black, width: 1)
            }
        }
    }
}




#Preview {
    CustomLayout()
}
// MARK: - Cuustom Stack
struct Stack<Element, Content: View>: View {
    
    var elements: [Element]
    
    var spacing: CGFloat = 8
    var axis: Axis = .horizontal
    var alignment: Alignment = .topLeading
    
    //view making closure
    var content: (Element) -> Content
    @State private var offsets: [CGPoint] = []
    
    var body: some View {
        ZStack(alignment: alignment){
            ForEach(elements.indices, id: \.self) { index in
                content(elements[index])
                    .collectSize(index: index) //capture size of view and add it to preference dict
                    .alignmentGuide(self.alignment.horizontal, computeValue: { dimension in
                        self.axis == .horizontal ? -self.offset(at: index).x : dimension[self.alignment.horizontal]
                    })
                    .alignmentGuide(self.alignment.vertical, computeValue: { dimension in
                        self.axis == .vertical ? -self.offset(at: index).y : dimension[self.alignment.vertical]
                    })
            }
        }
        .onPreferenceChange(CollectSizePreference.self, perform: { value in
            self.computeOffsets(sizes: value)
        })
        
    }
    
    private func computeOffsets(sizes: [Int:CGSize]){
        guard !sizes.isEmpty else { return }
        var offsets: [CGPoint] = [.zero]
        for i in 0..<self.elements.count{
            guard let size = sizes[i] else { fatalError()}
            var newPoint = offsets.last!
            newPoint.x += size.width + self.spacing
            newPoint.y += size.height + self.spacing
            offsets.append(newPoint)
        }
        self.offsets = offsets
    }
    
    private func offset(at index: Int) -> CGPoint{
        guard index < self.offsets.endIndex else { return .zero}
        return self.offsets[index]
    }
}


// MARK: - Collect Size
struct CollectSizePreference: PreferenceKey{
    typealias Value = [Int : CGSize]
    static var defaultValue: [Int : CGSize] = [:]
    static func reduce(value: inout [Int : CGSize], nextValue: () -> [Int : CGSize]) {
        value.merge(nextValue()) { $1}
    }
}

struct CollectSize: ViewModifier{
    var index: Int
    func body(content: Content) -> some View {
        content
            .background{
                GeometryReader{ geo in
                    Color.clear.preference(key: CollectSizePreference.self, value: [self.index: geo.size])
                }
            }
    }
}

extension View {
    func collectSize(index: Int) -> some View {
        self.modifier(CollectSize(index: index))
    }
}





