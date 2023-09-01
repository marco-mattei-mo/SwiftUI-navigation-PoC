import SwiftUI

enum Route: Hashable {
    case firstTabHomeView
    case secondTabHomeView
    case itemDetails(id: Int)
    case info
    case secondTabFirstLevel
    case secondTabSecondLevel
    case secondTabThirdLevel
    case secondTabFullScreen(isFullScreen: Bool)
}

extension Route: Identifiable {
    var id: Self { self }
}

extension Route {
    @ViewBuilder
    func getView() -> RouteView {
        RouteView(route: self)
    }
}

extension Route {
    func getCompleteNavStack() -> [Route] {
        switch self {
        case .secondTabThirdLevel:
            return [.secondTabFirstLevel, .secondTabSecondLevel, .secondTabThirdLevel]
        default:
            return [self]
        }
    }
}
