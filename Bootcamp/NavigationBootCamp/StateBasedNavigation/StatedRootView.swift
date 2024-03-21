import SwiftUI

struct StatedRootView: View {
    
    @StateObject private var stateManager: StateManager = StateManager()
    @State private var isVisible: Bool = false
    
    var body: some View {
        ZStack{
            
                switch stateManager.state {
                case .open:
                    OpenView()
                        .transition(.opacity)

                case .first:
                    FirstView()
                        .transition(.opacity)

                case .second:
                    SecondView()
                        .transition(.opacity)

                case .final:
                    Finalview()
                        .transition(.opacity)

                }
            
        }
        .frame(width: 300,height: 200)
        .border(Color.red)
        .environmentObject(stateManager)
    }
}

#Preview {
    StatedRootView()
}
