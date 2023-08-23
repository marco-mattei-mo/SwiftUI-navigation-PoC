import Foundation

extension AppNavigationState {
    private enum DeeplinkPath: String {
        case orders
    }
    
    private enum DeeplinkOrdersPath: String {
        case all
        case details
    }
    
    func handleUrl(_ url: URL) {
        do {
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
            
            guard let host = components.host else {
                throw DeeplinkError.invalidURL
            }
            
            guard let section = AppSection(rawValue: host) else {
                throw DeeplinkError.unrecognizedHost
            }
            
            dismissCoverAndSheet()
            
            switch section {
            case .firstTab:
                selectTab(.firstTab)
                let navStack = try FirstTabDeeplinkResolver().resolveNavStackForURL(components)
                firstTabRouter.replace(with: navStack)
            case .secondTab:
                selectTab(.secondTab)
                let navStack = try SecondTabDeeplinkResolver().resolveNavStackForURL(components)
                secondTabRouter.replace(with: navStack)
            case .fullScreenCover:
                presentFullScreenCover(screen: .secondTabFullScreen)
                let navStack = try SecondTabDeeplinkResolver().resolveNavStackForURL(components)
                fullScreenRouter.replace(with: navStack)
            }
        } catch {
            print("deeplink failure")
        }
    }
}
