import Foundation

extension ConcreteAppNavigationController {
    func handleUrl(_ url: URL) {
        do {
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
            
            guard let host = components.host else {
                throw DeeplinkError.invalidURL
            }
            
            guard let section = DeeplinkAppSection(rawValue: host) else {
                throw DeeplinkError.unrecognizedHost
            }
            
            dismissAllSheetsAndCovers()
            
            switch section {
            case .firstTab:
                selectTab(.firstTab)
                let navStack = try FirstTabDeeplinkResolver().resolveNavStackForURL(components)
                //firstTabRouter.replace(with: navStack)
            case .secondTab:
                selectTab(.secondTab)
                let navStack = try SecondTabDeeplinkResolver().resolveNavStackForURL(components)
                //secondTabRouter.replace(with: navStack)
            case .fullScreenCover:
                //presentFullScreenCover(with: .secondTabFullScreen)
                let navStack = try SecondTabDeeplinkResolver().resolveNavStackForURL(components)
                //TODO: fullScreenRouter.replace(with: navStack)
            }
        } catch {
            print("deeplink failure")
        }
    }
}
