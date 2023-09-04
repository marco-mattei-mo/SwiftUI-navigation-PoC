import Combine

class ConcreteAppNavigationController: AppNavigationController {
    @Published var selectedTab: AppTab = .firstTab {
        didSet {
            currentRouter = getCurrentTabRouter()
            if oldValue == selectedTab {
                switch selectedTab {
                case .firstTab:
                    if firstTabRouter.stack.isEmpty {
                        scrollToTopFirstTab = true
                        return
                    }
                case .secondTab:
                    if secondTabRouter.stack.isEmpty {
                        scrollToTopSecondTab = true
                        return
                    }
                }
                popToRoot()
            }
        }
    }
    
    
    // Tab routers
    @Published var firstTabRouter = Router()
    @Published var secondTabRouter = Router()
    
    private var routersCancellables = Set<AnyCancellable>()
    
    // Scroll listeners
    @Published var scrollToTopFirstTab = false
    @Published var scrollToTopSecondTab = false
    
    enum ScrollAnchor {
        case firstTabTop
        case secondTabTop
    }
    
    lazy var currentRouter: Router = firstTabRouter
    var routerStack: [Router] = []
    
    init() {
        firstTabRouter.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }.store(in: &routersCancellables)
        secondTabRouter.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }.store(in: &routersCancellables)
    }

    func selectTab(_ tab: AppTab) {
        selectedTab = tab
    }
    
    func push(to route: Route) {
        currentRouter.push(to: RouteView(route: route))
    }
    
    func append(with routes: [Route]) {
        currentRouter.append(with: routes.map { RouteView(route: $0) })
    }
    
    func replace(with routes: [Route]) {
        currentRouter.replace(with: routes.map { RouteView(route: $0) })
    }
    
    func pop() {
        currentRouter.pop()
    }
    
    func pop(to route: Route) {
        currentRouter.pop(to: RouteView(route: route))
    }
    
    func popToRoot() {
        currentRouter.popToRoot()
    }
    
    func resetAll() {
        dismissAllSheetsAndCovers()
        selectedTab = .firstTab
        scrollToTopFirstTab = true
        scrollToTopSecondTab = true
        firstTabRouter.popToRoot()
        secondTabRouter.popToRoot()
        hideSnackbar()
    }
    
    func popSelectedTabToRoot() {
        switch selectedTab {
        case .firstTab:
            firstTabRouter.popToRoot()
        case .secondTab:
            secondTabRouter.popToRoot()
        }
    }
    
    func presentFullScreenCover(with route: Route) {
        currentView().presentFullScreenCover(with: RouteView(route: route))
        routerStack.append(currentRouter)
        currentRouter = currentView().viewModel.fullScreenRouter
    }
    
    func dismissFullScreenCover() {
        guard !routerStack.isEmpty else { return }
        currentRouter = routerStack.popLast()!
        currentView().dismissFullScreenCover()
    }
    
    func presentSheet(with route: Route) {
        currentView().setOnDismissSheet { [weak self] in
            self?.dismissSheet()
        }
        currentView().presentSheet(with: RouteView(route: route))
        routerStack.append(currentRouter)
        currentRouter = currentView().viewModel.sheetRouter
    }
    
    func dismissSheet() {
        guard !routerStack.isEmpty else { return }
        currentRouter = routerStack.popLast()!
        currentView().setOnDismissSheet(nil)
        currentView().dismissSheet()
    }
    
    func showSnackbar(message: String) {
        currentView().showSnackbar(message: message)
    }
    
    func hideSnackbar() {
        currentView().hideSnackbar()
    }
    
    func showAlert(title: String, message: String, buttons: [AlertButton]) {
        currentView().showAlert(title: title, message: message, buttons: buttons)
    }
    
    func currentView() -> RouteView {
        currentRouter.currentView()
    }
    
    func dismissAllSheetsAndCovers() {
        while !routerStack.isEmpty {
            currentRouter = routerStack.popLast()!
            if currentView().viewModel.presentedFullScreen != nil {
                currentView().dismissFullScreenCover()
            }
            if currentView().viewModel.presentedSheet != nil {
                currentView().setOnDismissSheet(nil)
                currentView().dismissSheet()
            }
        }
        currentRouter = getCurrentTabRouter()
    }
    
    func getCurrentTabRouter() -> Router {
        switch selectedTab {
        case .firstTab:
            return firstTabRouter
        case .secondTab:
            return secondTabRouter
        }
    }
}
