//
//  CustomLayoutPROSUI.swift
//  Bootcamp
//
//  Created by Миляев Максим on 19.03.2024.
//

import SwiftUI

struct CustomLayoutPROSUI: View {
    
    let layouts = [AnyLayout(VStackLayout()),
                   AnyLayout(HStackLayout()),
                   AnyLayout(ZStackLayout()),
                   AnyLayout(GridLayout()),
                   AnyLayout(RadialLayout()),
                   AnyLayout(EqualWidthHStack()),
                   AnyLayout(MasonryLayout())
    ]
    @State private var currentLayout = 0
    var layout: AnyLayout { layouts[currentLayout] }
    
    @State private var count = 8
    
    @State private var columns = 3
    @State private var views = (0..<20).map { _ in
        CGSize(width: .random(in: 100...500),
               height: .random(in: 100...500))
    }
    
    var body: some View {
//  //      masonryView
//        ScrollView {
//            MasonryLayout(columns: columns,spacing: 2) {
//                ForEach(0..<20) { i in
//                    PlaceholderView(size: views[i],num: i)
//                }
//            }
//            .padding(.horizontal, 5)
//        }
//        .safeAreaInset(edge: .bottom) {
//            Stepper("Columns: \(columns)", value: $columns, in:
//                        1...5)
//            .padding()
//            .background(.regularMaterial)
//        }
        
 //       //Equal HStack layout
//        EqualWidthHStack{
//            Text("shorterss")
//                .background(.red)
//            Text("shorterss")
//                .background(.green)
//            Text("shorterss")
//                .background(.blue)
//            Text("shorterss")
//                .background(.orange)
//            Text("shorterss")
//                .background(.yellow)
//        }
//        .border(.black)
        
        
      //  //radial layout
        //        RadialLayout(){
        //            ForEach(0..<count, id: \.self){_ in
        //            Circle()
        //                    .frame(width: 32, height: 32)
        //            }
        //        }
        //        .safeAreaInset(edge: .bottom){
        //            Stepper("Count: \(count)",
        //                    value: $count.animation(),
        //                    in: 0...36)
        //            .padding()
        //        }
        
        
//        layout showing
                VStack{
                    Spacer()
                    layout{
                        GridRow{
                            ExampleView(color: .red)
                            ExampleView(color: .green)
                        }
                        GridRow{
                            ExampleView(color: .blue)
                            ExampleView(color: .orange)
                        }
                        GridRow{
                            ExampleView(color: .black)
                            
                        }
                       
                    }
                    Spacer()
                    Button("Change Layout") {
                        withAnimation {
                            if currentLayout == layouts.count - 1{
                                currentLayout = 0
                            } else {
                                currentLayout += 1
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(width: 300, height: 300)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(40)
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.orange)
    }
}

#Preview {
    CustomLayoutPROSUI()
}


// MARK: - ExampleView
struct ExampleView: View {
    
    @State private var counter = 0
    let color: Color
    
    var body: some View {
        Button {
            counter += 1
        } label: {
            RoundedRectangle(cornerRadius: 10).fill(color)
                .overlay {
                    Text("\(counter)")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
            
        }
        .frame(width: 50, height: 50)
        .rotationEffect(.degrees(.random(in: -20...20)))
        
    }
}

// MARK: - Radial Layout

struct RadialLayout: Layout{
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let radius = min(bounds.width, bounds.height) / 2
        let angle = Angle(degrees: (360 / Double(subviews.count))).radians
        for (index, subview) in subviews.enumerated() {
            let viewSize = subview.sizeThatFits(.unspecified)
            let xPos = sin(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
            let yPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.height / 2)
            let point = CGPoint(x: bounds.midX + xPos,
                                y: bounds.midY + yPos)
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

// MARK: - Equal Width HStack
struct EqualWidthHStack: Layout{
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxSize = maxSize(across: subviews)
        let spacings = spacing(for: subviews)
        let totalSpacing = spacings.reduce(0, +)
        
        let result = CGSize(width: maxSize.width * Double(subviews.count) + totalSpacing,
                            height: maxSize.height)
        return result
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxSize = maxSize(across: subviews)
        let spacings = spacing(for: subviews)
        let proposal = ProposedViewSize(width: maxSize.width, height: maxSize.height)
        var x = bounds.minX + maxSize.width / 2
        
        for index in subviews.indices{
            subviews[index].place(at: CGPoint(x: x, y: bounds.midY), anchor: .center, proposal: proposal)
            x += maxSize.width + spacings[index]
        }
        
    }
    
    private func maxSize(across subviews: Subviews) -> CGSize{
//        var maxSize: CGSize = .zero
//        for subview in subviews {
//            let viewWidth = subview.sizeThatFits(.unspecified).width
//            let viewHeight = subview.sizeThatFits(.unspecified).height
//            maxSize.width = viewWidth > maxSize.width ?
//            viewWidth : maxSize.width
//            maxSize.height = viewHeight > maxSize.height ?
//            viewHeight : maxSize.height
//        }
//        return maxSize
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
          return sizes.reduce(.zero) { largest, next in
            CGSize(width: max(largest.width, next.width),
                   height: max(largest.height, next.height))
        }
    }
    
    private func spacing(for subviews: Subviews) -> [Double] {
//        var spacings = [Double]()
//        
//        for index in subviews.indices {
//            if index == subviews.count - 1 {
//                spacings.append(0)
//            } else {
//                let distance = subviews[index].spacing.distance(to: subviews[index + 1].spacing, along: .horizontal)
//                spacings.append(distance)
//            }
//        }
//        return spacings
        subviews.indices.map { index in
            guard index < subviews.count - 1 else { return 0 }
            return subviews[index].spacing.distance(to: subviews[index + 1].spacing,
                                                    along: .horizontal)
        }
    }
    
}

// MARK: - Masonry ("Waterfall") layout

struct MasonryLayout: Layout{
    
    // cache
    struct Cache {
        var width = 0.0
        var frames: [CGRect]
    }
    
    func makeCache(subviews: Subviews) -> Cache {
        Cache(frames: [])
    }
    
    //properties
    var columns: Int
    var spacing: Double
    
    init(columns: Int = 3, spacing: Double = 5) {
        self.columns = max(1,columns)
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
        let width = proposal.replacingUnspecifiedDimensions().width
        let viewFrames = frames(for: subviews, in: width)
        let height = viewFrames.max { $0.maxY < $1.maxY } ?? .zero
        cache.frames = viewFrames
        cache.width = width
        return CGSize(width: width, height: height.maxY)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
        if cache.width != bounds.width {
          cache.frames = frames(for: subviews, in: bounds.width)
          cache.width = bounds.width
        }
       // let viewFrames = frames(for: subviews, in: bounds.width)
        for index in subviews.indices {
            let frame = cache.frames[index]
            let position = CGPoint(x: bounds.minX + frame.minX,
                                   y: bounds.minY + frame.minY)
//            print("\(index) : \(String(describing: ProposedViewSize(frame.size).width))")
            subviews[index].place(at: position, proposal: ProposedViewSize(frame.size))
        }
    }
    
    func frames(for subviews: Subviews, in totalWidth: Double) -> [CGRect]{
        let totalSpacing = spacing * Double(columns - 1)
        let columnWidth = (totalWidth - totalSpacing) / Double(columns)
        let columnWithSpacing = columnWidth + spacing
        
        let proposedSize = ProposedViewSize(width: columnWidth, height: nil)
        
        var viewFrames = [CGRect]()
        var columnHeights = Array(repeating: 0.0, count: columns)
        
        for subview in subviews {
            var selectedColumn = 0
            var selectedHeight = Double.greatestFiniteMagnitude
            
            for (columnIndex, height) in columnHeights.enumerated(){
                if height < selectedHeight{
                    selectedColumn = columnIndex
                    selectedHeight = height
                }
            }
            
            let x = columnWithSpacing * Double(selectedColumn)
            let y = columnHeights[selectedColumn]
            
            let size = subview.sizeThatFits(proposedSize)
            
            let frame = CGRect(x: x, y: y, width: size.width, height: size.height)
            
            columnHeights[selectedColumn] += size.height + spacing
            viewFrames.append(frame)
        }
        
        return viewFrames
    }
}

// MARK: - Placeholder View
struct PlaceholderView: View {
    let color: Color = [.blue, .cyan, .green, .indigo, .mint, .orange, .pink, .purple,.red].randomElement()!
    let size: CGSize
    let num: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
            VStack{
                Text("\(num)")
                Text("\(Int(size.width))x\(Int(size.height))")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding(.vertical)
        }
        .aspectRatio(size, contentMode: .fit)
    }
}
