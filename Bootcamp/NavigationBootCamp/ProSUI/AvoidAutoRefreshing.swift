//
//  AvoidAutoRefreshing.swift
//  Bootcamp
//
//  Created by Миляев Максим on 02.04.2024.
//

import SwiftUI

struct AvoidAutoRefreshing: View {
    @StateObject private var viewModel = AutorefreshingObject()
    var body: some View {
        let _ = Self._printChanges()
        Text("Example View Here")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.random)
    }
}

#Preview {
    AvoidAutoRefreshing()
}


// MARK: - Autorefreshing object
class AutorefreshingObject: ObservableObject {
    var timer: Timer?
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5,
                                     repeats: true) { _ in
            self.objectWillChange.send()
        }
    }
}

