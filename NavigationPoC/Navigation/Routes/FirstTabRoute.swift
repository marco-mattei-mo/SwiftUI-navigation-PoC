import SwiftUI

enum FirstTabRoute: Route {
    var id: Self { self }
    
    case itemDetails(id: Int)
    case info
}

extension FirstTabRoute: View {
    var body: some View {
        switch self {
        case .itemDetails(let id):
            ItemDetailsView(id: id)
        case .info:
            InfoView()
        }
    }
}
