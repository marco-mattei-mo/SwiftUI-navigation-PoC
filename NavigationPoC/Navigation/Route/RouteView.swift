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
    @ObservedObject var viewModel: RouteViewModel = RouteViewModel()

    var body: some View {
        resolveConcreteView()
        .mSnackbar(isShowing: $viewModel.isSnackbarPresented, message: viewModel.snackbarMessage, messageType: .success)
        .fullScreenCover(item: $viewModel.presentedFullScreen, content: { route in
            MNavigationStack(path: $viewModel.fullScreenRouter.stack) {
                route
                    .mNavigationDestination(for: RouteView.self) { $0 }
            }.onAppear {
                viewModel.fullScreenRouter.rootView = route
            }
        })
        .sheet(item: $viewModel.presentedSheet, onDismiss: {
            viewModel.onDismissSheet?()
        }, content: { route in
            MNavigationStack(path: $viewModel.sheetRouter.stack) {
                route
                    .mNavigationDestination(for: RouteView.self) { $0 }
            }.onAppear {
                viewModel.sheetRouter.rootView = route
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
    
    @ViewBuilder
    private func resolveConcreteView() -> some View {
        switch route {
        case .firstTabHomeView:
            FirstTabHomeView()
        case .secondTabHomeView:
            SecondTabHomeView()
        case .itemDetails(let id):
            ItemDetailsView(id: id)
        case .info:
            InfoView()
        case .secondTabFirstLevel:
            FirstLevelView()
        case .secondTabSecondLevel:
            SecondLevelView()
        case .secondTabThirdLevel:
            ThirdLevelView()
        case .secondTabFullScreen(let isFullScreen):
            FullScreenSecondTabHomeView(isFullScreen: isFullScreen)
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
