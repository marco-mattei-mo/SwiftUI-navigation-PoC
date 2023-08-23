import SwiftUI

enum FullScreenRoute: Route {
    var id: Self { self }

    case secondTabFullScreen
}

extension FullScreenRoute: View {
    var body: some View {
        switch self {
        case .secondTabFullScreen:
            FullScreenSecondTabHomeView()
        }
    }
}
