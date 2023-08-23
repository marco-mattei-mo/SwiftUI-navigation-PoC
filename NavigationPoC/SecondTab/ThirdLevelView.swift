import SwiftUI

struct ThirdLevelView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var appNavState: AppNavigationState

    var body: some View {
        VStack {
            Text("Third level")
                .navigationTitle("Third level")
                .navigationBarTitleDisplayMode(.inline)
            
            Button {
                router.popToRoot()
            } label: {
                Text("Pop to root")
            }
            
            Button {
                router.pop(to: .secondTabFirstLevel)
            } label: {
                Text("Pop to first")
            }
            
            Button {
                appNavState.showSnackbar(message: "a snackbar message")
            } label: {
                Text("Show snackbar")
            }
        }
    }
}

struct ThirdLevelView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdLevelView()
            .environmentObject(Router())
            .environmentObject(AppNavigationState())
    }
}
