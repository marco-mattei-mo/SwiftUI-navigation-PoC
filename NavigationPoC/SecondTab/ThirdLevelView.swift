import SwiftUI
import Factory

class ThirdLevelViewModel: ObservableObject {
    @Injected(\.appNavigationController) var appNavigationController
    
    func popToRoot() {
        appNavigationController.popToRoot()
    }
    
    func showSnackbar() {
        appNavigationController.showSnackbar(message: "a snackbar message")
    }
}

struct ThirdLevelView: View {
    @StateObject var viewModel = ThirdLevelViewModel()
    @Injected(\.appNavigationController) var appNavigationController
    
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
                appNavigationController.popToSecondTabFirstLevel()
            } label: {
                Text("Pop to first")
            }
            
            Button {
                viewModel.showSnackbar()
            } label: {
                Text("Show snackbar")
            }
        }
    }
}

struct ThirdLevelView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdLevelView()
    }
}
