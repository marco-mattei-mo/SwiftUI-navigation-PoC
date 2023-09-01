import Foundation
import SwiftUI

struct AlertButton: Identifiable {
    let id = UUID()
    let title: String
    let role: ButtonRole?
    let action: () async -> Void
    
    init(title: String, role: ButtonRole? = nil, action: @escaping () -> Void) {
        self.title = title
        self.role = role
        self.action = action
    }
}
