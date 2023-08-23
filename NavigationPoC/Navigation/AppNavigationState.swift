import Combine

class AppNavigationState: ObservableObject {
    
    static let shared = AppNavigationState()
    
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
                    if secondTabRouter.stack.isEmpty {
                        scrollToTopSecondTab = true
                    } else {
                        popSelectedTabToRoot()
                    }
                }
            }
        }
    }
    
    // Tab routers
    let firstTabRouter = Router<FirstTabRoute>()
    let secondTabRouter = Router<SecondTabRoute>()
    
    // Scroll listeners
    @Published var scrollToTopFirstTab = false
    @Published var scrollToTopSecondTab = false
    
    enum ScrollAnchor {
        case firstTabTop
        case secondTabTop
    }
    
    // Full screen, sheets and snackbar properties
    @Published var presentedFullScreen: FullScreenRoute? = nil
    @Published var presentedSheet: SheetRoute? = nil

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
    
    func presentFullScreenCover(screen: FullScreenRoute) {
        presentedFullScreen = screen
    }
    
    func dismissFullScreenCover() {
        presentedFullScreen = nil
    }
    
    func presentSheet(screen: SheetRoute) {
        presentedSheet = screen
    }
    
    func dismissSheet() {
        presentedSheet = nil
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
