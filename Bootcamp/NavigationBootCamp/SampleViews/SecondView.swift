//
//  SecondView.swift
//  Bootcamp
//
//  Created by Миляев Максим on 02.03.2024.
//

import SwiftUI

struct SecondView: View {
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        ZStack{
            Color.red.ignoresSafeArea()
            VStack{
                Text("It is Second View!")
                    .font(.title)
                    .fontDesign(.rounded)
                Button{
                    stateManager.nextState()
                }label: {
                    Text("Go Next State")
                        .font(.title2)
                        .padding(.vertical,10)
                        .frame(maxWidth: .infinity)
                        .background {
                            Color.orange
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    SecondView().environmentObject(StateManager())
}
