import Combine

class Router<RouteType: Hashable>: ObservableObject {
    @Published var stack = [RouteType]()

    func push(to screen: RouteType) {
        stack.append(screen)
    }
    
    func replace(with stack: [RouteType]) {
        self.stack = stack
    }
    
    func pop() {
        _ = stack.popLast()
    }
    
    func pop(to: RouteType) {
        guard let indexOfScreen = stack.lastIndex(of: to) else { return }
        
        stack.removeLast(stack.count - 1 - indexOfScreen)
    }
    
    func popToRoot() {
        stack = []
    }
}
