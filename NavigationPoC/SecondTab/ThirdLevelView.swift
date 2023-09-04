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
    @State var isAlertPresented = false
    
    var alertButtons = [AlertButton(title: "CancelBut", role: .cancel, action: {
        print("cancel")
    }), AlertButton(title: "Destroy", role: .destructive, action: {
        print("Destroy")
    }), AlertButton(title: "Test", action: {
        print("Test")
    })]
    
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
                appNavigationController.pop(to: .secondTabFirstLevel)
            } label: {
                Text("Pop to first")
            }
            
            Button {
                viewModel.showSnackbar()
            } label: {
                Text("Show snackbar")
            }
            
            Button {
                appNavigationController.dismissAllSheetsAndCovers()
            } label: {
                Text("dismiss all sheets and covers")
            }
            
            Button {
                appNavigationController.resetAll()
            } label: {
                Text("reset all")
            }
            
            Button {
                appNavigationController.showAlert(title: "Tes", message: "Test", buttons: alertButtons)
            } label: {
                Text("Show alert")
            }
        }
    }
}

struct ThirdLevelView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdLevelView()
    }
}
