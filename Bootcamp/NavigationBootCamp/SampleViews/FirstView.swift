//
//  FirstView.swift
//  Bootcamp
//
//  Created by Миляев Максим on 02.03.2024.
//

import SwiftUI

struct FirstView: View {
    @EnvironmentObject var stateManager: StateManager
    
    var body: some View {
        ZStack{
            Color.yellow.ignoresSafeArea()
            VStack{
                Text("It is First View!")
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
                            Color.green
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    FirstView().environmentObject(StateManager())
}
