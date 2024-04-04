//
//  Ext+View+DEBUG.swift
//  Bootcamp
//
//  Created by Миляев Максим on 02.04.2024.
//

import SwiftUI

extension View {
    func debugPrint(_ value: @autoclosure () -> Any) -> some View
    {
#if DEBUG
        print(value())
#endif
        return self
    }
    func debugExecute(_ function: () -> Void) -> some View {
#if DEBUG
        function()
#endif
        return self
    }
    func debugExecute(_ function: (Self) -> Void) -> some View {
#if DEBUG
        function(self)
#endif
        return self
    }
}

extension View {
    public func assert(
        _ condition: @autoclosure () -> Bool,
        _ message: @autoclosure () -> String = String(),
        file: StaticString = #file, line: UInt = #line
    ) -> some View {
        Swift.assert(condition(), message(), file: file, line:
                        line)
        return self
    }
}

//struct AssertExmpleUsage: View {
//    @State private var counter = 0
//    @State var timer = Timer.publish(every: 1, on: .main,
//                              in: .common).autoconnect()
//    var body: some View {
//        Text("Example View Here")
//            .onReceive(timer) { _ in
//                print("\(counter)")
//                counter += 1
//            }
//            .assert(counter < 15, "Timer exceeded")
//    }
//}
//
//#Preview {
//    AssertExmpleUsage()
//}
