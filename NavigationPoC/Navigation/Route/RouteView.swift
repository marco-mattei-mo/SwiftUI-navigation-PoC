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
        .fullScreenCover(item: $viewModel.presentedFullScreen, onDismiss: {
            viewModel.onDismissFullScreenCover?()
        }, content: { presentedFullScreenView in
            MNavigationStack(path: $viewModel.fullScreenRouter.stack) {
                presentedFullScreenView
                    .mNavigationDestination(for: RouteView.self) { $0 }
            }.onAppear {
                viewModel.fullScreenRouter.rootView = presentedFullScreenView
            }
        })
        .sheet(item: $viewModel.presentedSheet, onDismiss: {
            viewModel.onDismissSheet?()
        }, content: { presentedSheetView in
            MNavigationStack(path: $viewModel.sheetRouter.stack) {
                presentedSheetView
                    .mNavigationDestination(for: RouteView.self) { $0 }
            }.onAppear {
                viewModel.sheetRouter.rootView = presentedSheetView
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
}
