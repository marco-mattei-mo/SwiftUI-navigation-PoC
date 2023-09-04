import SwiftUI

enum Route: Equatable {
    case firstTabHomeView
    case secondTabHomeView
    case itemDetails(id: Int)
    case info
    case secondTabFirstLevel
    case secondTabSecondLevel
    case secondTabThirdLevel
    case secondTabFullScreen(isFullScreen: Bool)
}

extension Route {
    func getCompleteNavStack() -> [Route] {
        switch self {
        case .secondTabThirdLevel:
            return [.secondTabFirstLevel,
                    .secondTabSecondLevel,
                    .secondTabThirdLevel]
        default:
            return [self]
        }
    }
}
