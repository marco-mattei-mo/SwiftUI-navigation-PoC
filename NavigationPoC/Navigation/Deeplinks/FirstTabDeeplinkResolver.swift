import Foundation

struct FirstTabDeeplinkResolver: DeeplinkResolver {    
    private enum DeeplinkPath: String {
        case item
        case info
    }
    
    private enum DeeplinkItemPath: String {
        case details
    }
    
    func resolveNavStackForURL(_ components: URLComponents) throws -> [Route] {
        guard components.host == AppSection.firstTab.rawValue else {
            throw DeeplinkError.unrecognizedHost
        }
        
        var path = components.path.split(separator: "/")
        guard !path.isEmpty else { throw DeeplinkError.unrecognizedPath }
        
        let deeplinkPath = DeeplinkPath(rawValue: String(path.removeFirst()))
        switch deeplinkPath {
        case .item:
            return try handleItem(components, path: &path)
        case .info:
            return try handleInfo(components, path: &path)
        default:
            throw DeeplinkError.unrecognizedPath
        }
    }
    
    private func handleItem(_ components: URLComponents, path: inout [String.SubSequence]) throws -> [Route] {
        let deeplinkPath = DeeplinkItemPath(rawValue: String(path.removeFirst()))
        
        switch deeplinkPath {
        case .details:
            let stringItemId = (components.path as NSString).lastPathComponent
            guard let itemId = Int(stringItemId) else { throw DeeplinkError.unrecognizedPath }
            return [.itemDetails(id: itemId)]
        default:
            throw DeeplinkError.unrecognizedPath
        }
    }
    
    private func handleInfo(_ components: URLComponents, path: inout [String.SubSequence]) throws -> [Route] {
        return [.info]
    }
}
