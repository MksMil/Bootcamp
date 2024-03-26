import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        NavigationStack{
            
            List{
                Section("PROSUI") {
                    NavigationLink("Custom Layout") {
                        CustomLayoutPROSUI()
                    }
                    NavigationLink("Explore Tab") {
                        ExploreTab()
                    }
                    NavigationLink("PrefferencesPROSUI") {
                        PrefferencesPROSUI()
                    }
                    NavigationLink("EnvironmentBtCmp") {
                        EnvironmentBtCmp()
                    }
                    NavigationLink("EnvObjAndEnvValue") {
                        EnvObjAndEnvValue()
                    }
                    NavigationLink("Unanimatable") {
                        Unanimatable()
                    }
                    NavigationLink("TransactionUseless") {
                        TransactionUseless()
                    }
                    NavigationLink("CircleGrid") {
                        ResultView()
                    }
                    NavigationLink("HeartAnimation") {
                        HeartAnimation()
                    }
                    NavigationLink("ParentsAndChildren") {
                        ParentsAndChildren()
                    }
                    NavigationLink("IdentityUnderstanding") {
                        IdentityUnderstanding()
                    }
                    NavigationLink("chattest") {
                        chattest()
                    }
                    NavigationLink("DrawingWithCanvas") {
                        DrawingWithCanvas()
                    }
                }
                Section("SUI thinking") {
                    NavigationLink("Animations") {
                        Animations()
                    }
                    NavigationLink("CustomAnimations") {
                        CustomAnimations()
                    }
                    NavigationLink("PathAnimation") {
                        PathAnimation()
                    }
                    NavigationLink("ButtonStyleBtCmp") {
                        ButtonStyleBtCmp()
                    }
                    NavigationLink("ColapsableHStack") {
                        ColapsableHStack()
                    }
                    NavigationLink("CustomBadge") {
                        CustomBadge()
                    }
                    NavigationLink("AnchorBtCmp") {
                        AnchorBtCmp()
                    }
                    NavigationLink("CustomLayout") {
                        CustomLayout()
                    }
                    NavigationLink("SelectableTable") {
                        SelectableTable()
                    }
                    NavigationLink("KnobCV") {
                        KnobCV()
                    }
                    NavigationLink("ImageLoader") {
                        ImageLoader()
                    }
                    
                }
            }
            
        }
    }
}


#Preview {
    ContentView()
}
