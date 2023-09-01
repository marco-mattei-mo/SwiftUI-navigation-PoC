import Combine

class RouteViewModel: ObservableObject {
    @Published var presentedFullScreen: RouteView? = nil
    @Published var presentedSheet: RouteView? = nil
    var onDismissSheet: (() -> Void)?
    
    @Published var isSnackbarPresented: Bool = false
    @Published var snackbarMessage: String = ""
    
    @Published var isAlertPresented: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var alertButtons: [AlertButton] = []
    
    func presentFullScreenCover(with route: RouteView) {
        presentedFullScreen = route
    }

    
    func presentSheet(with route: RouteView) {
        presentedSheet = route
    }
    
    func showSnackbar(message: String) {
        isSnackbarPresented = true
        snackbarMessage = message
    }
    
    func hideSnackbar() {
        isSnackbarPresented = false
    }
    
    func showAlert(title: String, message: String, buttons: [AlertButton]) {
        alertTitle = title
        alertMessage = message
        alertButtons = buttons
        isAlertPresented = true
    }
}
