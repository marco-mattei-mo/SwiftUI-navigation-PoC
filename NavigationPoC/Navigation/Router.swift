import Combine

class Router: ObservableObject {
    @Published var stack = [Route]()

    func push(to screen: Route) {
        stack.append(screen)
    }
    
    func replace(with stack: [Route]) {
        self.stack = stack
    }
    
    func pop() {
        _ = stack.popLast()
    }
    
    func pop(to: Route) {
        guard let indexOfScreen = stack.lastIndex(of: to) else { return }
        
        stack.removeLast(stack.count - 1 - indexOfScreen)
    }
    
    func popToRoot() {
        stack = []
    }
}
