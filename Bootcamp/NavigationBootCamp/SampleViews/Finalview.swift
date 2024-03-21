//
//  Finalview.swift
//  Bootcamp
//
//  Created by Миляев Максим on 02.03.2024.
//

import SwiftUI

struct Finalview: View {
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        ZStack{
            Color.orange.ignoresSafeArea()
            VStack{
                Text("It is Final View!")
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
                            Color.white
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    Finalview().environmentObject(StateManager())
}
