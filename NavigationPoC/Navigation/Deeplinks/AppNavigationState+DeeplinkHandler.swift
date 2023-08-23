import Foundation

extension AppNavigationState {    
    func handleUrl(_ url: URL) {
        do {
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
            
            guard let host = components.host else {
                throw DeeplinkError.invalidURL
            }
            
            guard let section = DeeplinkAppSection(rawValue: host) else {
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
                //TODO: How to push to correct view in full screen cover ? fullScreenRouter.replace(with: navStack)
            }
        } catch {
            print("deeplink failure")
        }
    }
}
