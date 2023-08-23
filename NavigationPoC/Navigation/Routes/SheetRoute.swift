import SwiftUI

enum SheetRoute: Route {
    var id: Self { self }

    case secondTabFullScreen
}

extension SheetRoute: View {
    var body: some View {
        switch self {
        case .secondTabFullScreen:
            FullScreenSecondTabHomeView()
        }
    }
}
