import SwiftUI

struct RouteView: View, Hashable, Identifiable {
    static func == (lhs: RouteView, rhs: RouteView) -> Bool {
        lhs.route == rhs.route
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    let id = UUID()
    let route: Route
    let content: AnyView
    @ObservedObject var viewModel = RouteViewModel()
    @ObservedObject var sheetRouter = Router()
    @ObservedObject var fullScreenRouter = Router()

    var body: some View {
        content
        .mSnackbar(isShowing: $viewModel.isSnackbarPresented, message: viewModel.snackbarMessage, messageType: .success)
        .fullScreenCover(item: $viewModel.presentedFullScreen, content: { route in
            MNavigationStack(path: $fullScreenRouter.stack) {
                route
                    .mNavigationDestination(for: RouteView.self) { $0 }
            }.onAppear {
                fullScreenRouter.rootView = route
            }
        })
        .sheet(item: $viewModel.presentedSheet, onDismiss: {
            viewModel.onDismissSheet?()
        }, content: { route in
            MNavigationStack(path: $sheetRouter.stack) {
                route
                    .mNavigationDestination(for: RouteView.self) { $0 }
            }.onAppear {
                sheetRouter.rootView = route
            }
        })
        .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertPresented) {
            ForEach(viewModel.alertButtons) { alertButton in
                Button(alertButton.title, role: alertButton.role, action: {
                    Task {
                        await alertButton.action()
                    }
                })
            }
        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    func presentFullScreenCover(with route: RouteView) {
        viewModel.presentFullScreenCover(with: route)
    }
    
    func dismissFullScreenCover() {
        viewModel.presentedFullScreen = nil
    }
    
    func presentSheet(with route: RouteView) {
        viewModel.presentSheet(with: route)
    }
    
    func dismissSheet() {
        viewModel.presentedSheet = nil
    }
    
    func showSnackbar(message: String) {
        viewModel.showSnackbar(message: message)
    }
    
    func hideSnackbar() {
        viewModel.hideSnackbar()
    }
    
    func showAlert(title: String, message: String, buttons: [AlertButton]) {
        viewModel.showAlert(title: title, message: message, buttons: buttons)
    }
    
    func setOnDismissSheet(_ onDismissSheet: (() -> Void)?) {
        viewModel.onDismissSheet = onDismissSheet
    }
}
