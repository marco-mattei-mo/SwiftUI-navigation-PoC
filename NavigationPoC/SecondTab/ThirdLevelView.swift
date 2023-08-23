import SwiftUI

class ThirdLevelViewModel: ObservableObject {
    let appNavState: AppNavigationState
    var viewRouter: Router<SecondTabRoute>? // If required, can be injected with "setViewRouter()"
    
    init(appNavState: AppNavigationState = DIContainer.appNavState,
         viewRouter: Router<SecondTabRoute>? = nil) {
        self.appNavState = appNavState
        self.viewRouter = viewRouter
    }
    
    func setViewRouter(viewRouter: Router<SecondTabRoute>?) {
        self.viewRouter = viewRouter
    }
    
    func popToRoot() {
        viewRouter?.popToRoot()
    }
    
    func showSnackbar() {
        appNavState.showSnackbar(message: "a snackbar message")
    }
}

struct ThirdLevelView: View {
    @EnvironmentObject var router: Router<SecondTabRoute>
    @EnvironmentObject var appNavState: AppNavigationState
    @StateObject var viewModel = ThirdLevelViewModel()
    
    var body: some View {
        VStack {
            Text("Third level")
                .navigationTitle("Third level")
                .navigationBarTitleDisplayMode(.inline)
            
            Button {
                viewModel.popToRoot()
            } label: {
                Text("Pop to root")
            }
            
            Button {
                router.pop(to: .secondTabFirstLevel)
            } label: {
                Text("Pop to first")
            }
            
            Button {
                viewModel.showSnackbar()
            } label: {
                Text("Show snackbar")
            }
        }
        .onAppear {
            viewModel.setViewRouter(viewRouter: router) // Inject router 'onAppear()'
        }
    }
}

struct ThirdLevelView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdLevelView()
            .environmentObject(Router<SecondTabRoute>())
            .environmentObject(AppNavigationState())
    }
}
