import SwiftUI

enum Route: Hashable, Identifiable {
    var id: Self { self }

    case firstTabHomeView
    case secondTabHomeView
    case itemDetails(id: Int)
    case info
    case secondTabFirstLevel
    case secondTabSecondLevel
    case secondTabThirdLevel
    case secondTabFullScreen(isFullScreen: Bool)
    
    
    func getView() -> RouteView {
        let view = {
            switch self {
            case .firstTabHomeView:
                return AnyView(FirstTabHomeView())
            case .secondTabHomeView:
                return AnyView(SecondTabHomeView())
            case .itemDetails(let id):
                return AnyView(ItemDetailsView(id: id))
            case .info:
                return AnyView(InfoView())
            case .secondTabFirstLevel:
                return AnyView(FirstLevelView())
            case .secondTabSecondLevel:
                return AnyView(SecondLevelView())
            case .secondTabThirdLevel:
                return AnyView(ThirdLevelView())
            case .secondTabFullScreen(let isFullScreen):
                return AnyView(FullScreenSecondTabHomeView(isFullScreen: isFullScreen))
            }
        }
        
        return RouteView(route: self, content: view())
    }
}

extension Route {
    func getCompleteNavStack() -> [RouteView] {
        switch self {
        case .secondTabThirdLevel:
            return [Route.secondTabFirstLevel.getView(), Route.secondTabSecondLevel.getView(), Route.secondTabThirdLevel.getView()]
        default:
            return [self.getView()]
        }
    }
}
