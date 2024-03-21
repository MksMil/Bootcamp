//
//  CustomAlignment.swift
//  Bootcamp
//
//  Created by Миляев Максим on 08.03.2024.
//

import SwiftUI

enum MyCenterID: AlignmentID{
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context.height / 2
    }
}

extension VerticalAlignment {
    static let myCenter: VerticalAlignment = VerticalAlignment(MyCenterID.self)
}

struct CustomAlignment: View {
    var body: some View {
        HStack(alignment: .myCenter){
            Rectangle().fill(Color.red).frame(width: 150, height: 150)
            Rectangle().fill(Color.green).frame(width: 50, height: 50)
            Rectangle().fill(Color.blue).frame(width: 100, height: 100)
                .alignmentGuide(.myCenter, computeValue: { dimension in
                    dimension[.myCenter] - 50
                })
//                .offset(y: 50)
        }
        .border(.black, width: 2)
    }
}

#Preview {
    CustomAlignment()
}
