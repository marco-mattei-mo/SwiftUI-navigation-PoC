import SwiftUI
import Combine

class RouteViewModel: ObservableObject {
    @Published var presentedFullScreen: RouteView? = nil
    @Published var fullScreenRouter = Router()
    
    @Published var presentedSheet: RouteView? = nil
    @Published var sheetRouter = Router()
    
    @Published var isSnackbarPresented: Bool = false
    @Published var snackbarMessage: String = ""
    private var routersCancellables = Set<AnyCancellable>()
    
    @Published var isAlertPresented: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var alertButtons: [AlertButton] = []
    
    var onDismissSheet: (() -> Void)?

    init() {
        fullScreenRouter.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }.store(in: &routersCancellables)
        sheetRouter.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }.store(in: &routersCancellables)
    }
    
    func presentFullScreenCover(with route: RouteView) {
        presentedFullScreen = route
    }
    
    func dismissFullScreenCover() {
        presentedFullScreen = nil
        fullScreenRouter.popToRoot()
    }
    
    func presentSheet(with route: RouteView) {
        presentedSheet = route
    }
    
    func dismissSheet() {
        presentedSheet = nil
        sheetRouter.popToRoot()
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

struct RouteView: View, Hashable, Identifiable {
    static func == (lhs: RouteView, rhs: RouteView) -> Bool {
        lhs.route == rhs.route
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    let id = UUID()
    let route: Route
    @ObservedObject var viewModel = RouteViewModel()
            
    var body: some View {
        Group {
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
        .mSnackbar(isShowing: $viewModel.isSnackbarPresented, message: viewModel.snackbarMessage, messageType: .success)
        .fullScreenCover(item: $viewModel.presentedFullScreen, content: { route in
            MNavigationStack(path: $viewModel.fullScreenRouter.stack) {
                route
                    .mNavigationDestination(for: RouteView.self) { $0 }
            }.onAppear {
                viewModel.fullScreenRouter.homeView = route
            }
        })
        .sheet(item: $viewModel.presentedSheet, onDismiss: {
            viewModel.onDismissSheet?()
        }, content: { route in
            MNavigationStack(path: $viewModel.sheetRouter.stack) {
                route
                    .mNavigationDestination(for: RouteView.self) { $0 }
            }.onAppear {
                viewModel.sheetRouter.homeView = route
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
        .onAppear {
            viewModel.fullScreenRouter.homeView = self
            viewModel.sheetRouter.homeView = self
            print("self: \(self.id)")
        }
    }
    
    func presentFullScreenCover(with route: RouteView) {
        viewModel.presentFullScreenCover(with: route)
    }
    
    func dismissFullScreenCover() {
        viewModel.dismissFullScreenCover()
    }
    
    func presentSheet(with route: RouteView) {
        viewModel.presentSheet(with: route)
    }
    
    func dismissSheet() {
        viewModel.dismissSheet()
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
