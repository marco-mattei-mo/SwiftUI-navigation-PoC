import SwiftUI

enum SecondTabRoute: Route {
    var id: Self { self }

    case secondTabFirstLevel
    case secondTabSecondLevel
    case secondTabThirdLevel
}

extension SecondTabRoute: View {
    var body: some View {
        switch self {
        case .secondTabFirstLevel:
            FirstLevelView()
        case .secondTabSecondLevel:
            SecondLevelView()
        case .secondTabThirdLevel:
            ThirdLevelView()
        }
    }
}
