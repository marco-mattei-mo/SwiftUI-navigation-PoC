import Combine

class AppNavigationState: ObservableObject {
    enum AppTab {
        case firstTab
        case secondTab
    }
    
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
}
