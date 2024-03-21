//
//  StatedRooter.swift
//  Bootcamp
//
//  Created by Миляев Максим on 02.03.2024.
//

import SwiftUI

enum RootViewState: Int {
    case open = 0, first, second, final
    
    func nextState() -> RootViewState {
        return (self.rawValue < 3) ?
        RootViewState(rawValue: self.rawValue + 1)! : RootViewState(rawValue: 0)!
    }
}

final class StateManager: ObservableObject {
    @Published var state: RootViewState = .open
    
    func nextState(){
        withAnimation{
            state = state.nextState()
        }
    }
    
    func changeState(state: RootViewState){
        withAnimation{
            self.state = state
        }
    }
    
    
}
