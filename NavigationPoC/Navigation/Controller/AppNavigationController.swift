import Foundation
import SwiftUI

protocol AppNavigationController: ObservableObject {
    func resetAll()

    func push(to route: RouteView)
    func append(with routes: [RouteView])
    func pop()
    func pop(to route: RouteView)
    func popToRoot()
            
    func presentFullScreenCover(with route: RouteView)
    func dismissFullScreenCover()
    func presentSheet(with route: RouteView)
    func dismissSheet()
    func dismissAllSheetsAndCovers()
    
    func showSnackbar(message: String)
    func hideSnackbar()
    func currentView() -> RouteView
    
    func showAlert(title: String, message: String, buttons: [AlertButton])
    
    func handleUrl(_ url: URL)
}
