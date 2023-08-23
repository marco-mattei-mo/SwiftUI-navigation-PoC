import Foundation

protocol DeeplinkResolver {
    func resolveNavStackForURL(_ components: URLComponents) throws -> [Route]
}
