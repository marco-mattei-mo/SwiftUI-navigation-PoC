enum AppSection: String {
    case firstTab = "firstTab.app"
    case secondTab = "secondTab.app"
    case fullScreenCover = "fullScreenCover.app"
}

enum DeeplinkError: Error {
    case invalidURL
    case unrecognizedHost
    case unrecognizedPath
}
