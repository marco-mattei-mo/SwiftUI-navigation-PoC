import SwiftUI

enum Route: Hashable {
    case firstTabHomeView
    case secondTabHomeView
    case itemDetails(id: Int)
    case info
    case secondTabFirstLevel
    case secondTabSecondLevel
    case secondTabThirdLevel
    case secondTabFullScreen
}

extension Route: Identifiable {
    var id: Self { self }
}

extension Route: View {
    var body: some View {
        switch self {
        case .firstTabHomeView:
            FirstTabHomeView()
        case .secondTabHomeView:
            SecondTabHomeView()
        case .itemDetails(let id):
            ItemDetailsView(id: id)
        case .info:
            InfoView()
        case .secondTabFirstLevel:
            FirstLevelView()
        case .secondTabSecondLevel:
            SecondLevelView()
        case .secondTabThirdLevel:
            ThirdLevelView()
        case .secondTabFullScreen:
            FullScreenSecondTabHomeView()
        }
    }
}
