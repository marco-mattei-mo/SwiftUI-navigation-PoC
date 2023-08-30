import Combine

class ConcreteAppNavigationController: AppNavigationController {
    @Published var selectedTab: AppTab = .firstTab {
        didSet {
            if oldValue == selectedTab {
                switch selectedTab {
                case .firstTab:
                    if firstTabRouter.stack.isEmpty {
                        scrollToTopFirstTab = true
                    } else {
                        popSelectedTabToRoot()
                    }
                case .secondTab:
                    if firstTabRouter.stack.isEmpty {
                        scrollToTopSecondTab = true
                    } else {
                        popSelectedTabToRoot()
                    }
                }
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
    
    // Full screen, sheets and snackbar properties
    @Published var presentedFullScreen: Route? = nil
    @Published var fullScreenRouter = Router()
    
    @Published var presentedSheet: Route? = nil
    @Published var sheetRouter = Router()

    @Published var isSnackbarPresented: Bool = false
    @Published var snackbarMessage: String = ""
    
    init() {
        firstTabRouter.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }.store(in: &routersCancellables)
        secondTabRouter.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }.store(in: &routersCancellables)
        fullScreenRouter.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }.store(in: &routersCancellables)
        sheetRouter.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }.store(in: &routersCancellables)
    }

    func selectTab(_ tab: AppTab) {
        selectedTab = tab
    }
    
    func resetAll() {
        selectedTab = .firstTab
        scrollToTopFirstTab = true
        scrollToTopSecondTab = true
        firstTabRouter.popToRoot()
        secondTabRouter.popToRoot()
        dismissCoverAndSheet()
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
    
    func presentFullScreenCover(screen: Route) {
        presentedFullScreen = screen
    }
    
    func dismissFullScreenCover() {
        presentedFullScreen = nil
        fullScreenRouter.popToRoot()
    }
    
    func presentSheet(screen: Route) {
        presentedSheet = screen
    }
    
    func dismissSheet() {
        presentedSheet = nil
        sheetRouter.popToRoot()
    }
    
    func dismissCoverAndSheet() {
        dismissFullScreenCover()
        dismissSheet()
    }
    
    func showSnackbar(message: String) {
        isSnackbarPresented = true
        snackbarMessage = message
    }
    
    func hideSnackbar() {
        isSnackbarPresented = false
    }
    
    func currentStack() -> Router {
        if presentedFullScreen != nil {
            return fullScreenRouter
        }
        
        if presentedSheet != nil {
            return sheetRouter
        }
        
        switch selectedTab {
        case .firstTab:
            return firstTabRouter
        case .secondTab:
            return secondTabRouter
        }
    }
    
    func navigateToInfo() {
        currentStack().push(to: .info)
    }
    
    func openItemDetails(id: Int) {
        currentStack().push(to: .itemDetails(id: id))
    }
    
    func presentSecondTabAsFullScreen() {
       presentFullScreenCover(screen: .secondTabFullScreen)
    }
    
    func navigateToSecondTabFirstLevel() {
        currentStack().push(to: .secondTabFirstLevel)
    }
    
    func navigateToSecondTabThirdLevel(includeNavstack: Bool) {
        if includeNavstack {
            currentStack().replace(with: [.secondTabFirstLevel, .secondTabSecondLevel, .secondTabThirdLevel])
        } else {
            currentStack().push(to: .secondTabThirdLevel)
        }
    }
    
    func presentSecondTabAsSheet() {
        presentSheet(screen: .secondTabFullScreen)
    }
    
    func popToRoot() {
        currentStack().popToRoot()
    }
    
    func popToSecondTabFirstLevel() {
        currentStack().pop(to: .secondTabFirstLevel)
    }
}
