import Foundation

protocol AppNavigationController: ObservableObject {
    func resetAll()
    func popToRoot()

            
    func dismissFullScreenCover()
    func dismissSheet()
    func dismissCoverAndSheet()
    
    func showSnackbar(message: String)
    func hideSnackbar()
    func currentStack() -> Router
    
    func navigateToInfo()
    func openItemDetails(id: Int)
    func presentSecondTabAsFullScreen()
    
    func navigateToSecondTabFirstLevel()
    func navigateToSecondTabThirdLevel(includeNavstack: Bool)
    func presentSecondTabAsSheet()
    
    func popToSecondTabFirstLevel()
    
    func handleUrl(_ url: URL)
}
