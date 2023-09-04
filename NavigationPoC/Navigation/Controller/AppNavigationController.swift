import Foundation
import SwiftUI

protocol AppNavigationController: ObservableObject {
    func resetAll()

    func push(to route: Route)
    func append(with routes: [Route])
    func pop()
    func pop(to route: Route)
    func popToRoot()
            
    func presentFullScreenCover(with route: Route)
    func dismissFullScreenCover()
    func presentSheet(with route: Route)
    func dismissSheet()
    func dismissAllSheetsAndCovers()
    
    func showSnackbar(message: String)
    func hideSnackbar()
    func currentView() -> RouteView
    
    func showAlert(title: String, message: String, buttons: [AlertButton])
    
    func handleUrl(_ url: URL)
}
