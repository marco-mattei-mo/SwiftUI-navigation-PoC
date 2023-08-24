import Foundation

struct SecondTabDeeplinkResolver: DeeplinkResolver {    
    private enum DeeplinkPath: String {
        case firstLevel
        case secondLevel
        case thirdLevel
    }
    
    func resolveNavStackForURL(_ components: URLComponents) throws -> [Route] {
        guard components.host == DeeplinkAppSection.secondTab.rawValue || components.host == DeeplinkAppSection.fullScreenCover.rawValue else {
            throw DeeplinkError.unrecognizedHost
        }
                
        var path = components.path.split(separator: "/")
        guard !path.isEmpty else { throw DeeplinkError.unrecognizedPath }
        
        let deeplinkPath = DeeplinkPath(rawValue: String(path.removeFirst()))
        switch deeplinkPath {
        case .firstLevel:
            return [.secondTabFirstLevel]
        case .secondLevel:
            return [.secondTabFirstLevel, .secondTabSecondLevel]
        case .thirdLevel:
            return [.secondTabFirstLevel, .secondTabSecondLevel, .secondTabThirdLevel]
        default:
            throw DeeplinkError.unrecognizedPath
        }
    }
}
