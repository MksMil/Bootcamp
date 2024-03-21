//
//  View+debug.swift
//  Bootcamp
//
//  Created by Миляев Максим on 07.03.2024.
//

import SwiftUI

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
