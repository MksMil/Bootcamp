//
//  PerformanceShow.swift
//  Bootcamp
//
//  Created by Миляев Максим on 02.04.2024.
//

import SwiftUI
import Combine



struct PerformanceShow: View {
    @StateObject private var text = Debouncer(initialValue: "", delay: 0.5)
    @StateObject private var slider = Debouncer(initialValue: 0.0, delay: 0.1)
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        VStack {
            TextField("Search for something", text: $text.input)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            Text(text.output)
                .frame(maxWidth: .infinity,maxHeight: 50)
                .background(.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.horizontal)
            Spacer().frame(height: 30)
            Slider(value: $slider.input, in: 0...100)
                .padding(.horizontal)
            Text(slider.output.formatted(.number.precision(.fractionLength(1))))
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).fill(.gray.opacity(0.4)))
            Spacer().frame(height: 30)
            Divider().frame(height: 2).background(.red).padding(.horizontal)
            VStack(spacing: 30) {
                  Button("Do Work Soon", action: viewModel.scheduleWork)
                    .buttonStyle(.borderedProminent)
                  Button("Do Work Now", action: viewModel.doWorkNow)
                    .buttonStyle(.borderedProminent)
                }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 25.0).fill(.orange)
            }
            .padding()
            Text("\(viewModel.workCounter)")
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 5).fill(.red)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5).stroke(.black)
                        }
                }
                .foregroundStyle(.white)

        }
        .frame(maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    PerformanceShow()
}

// MARK: - Debouncer: reduce overUpdates of screen

class Debouncer<T> : ObservableObject {
    @Published var input: T
    @Published var output: T
    
    private var textDebounce: AnyCancellable?
    
    init(initialValue: T, delay: TimeInterval){
        self.input = initialValue
        self.output = initialValue
        
        textDebounce = $input
            .debounce(for: .seconds(delay),
                      scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.output = $0
            }
    }
}

// MARK: - Task sheduler

class ViewModel: ObservableObject {
    private var refreshTask: Task<Void, Error>?
    @Published var workCounter = 0
    
    func doWorkNow() {
        workCounter += 1
        print("Work done: \(workCounter)")
    }
    
    func scheduleWork() {
        refreshTask?.cancel()
        refreshTask = Task {
            try await Task.sleep(until: .now + .seconds(3),
                                 clock: .continuous)
            doWorkNow()
        }
    }
}


