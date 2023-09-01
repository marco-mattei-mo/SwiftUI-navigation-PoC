import Combine
import Foundation

class Router: ObservableObject {
    @Published var stack = [RouteView]()
    var homeView: RouteView?
    
    func currentView() -> RouteView {
        if stack.isEmpty {
            return homeView!
        } else {
            return stack.last!
        }
    }

    func push(to screen: RouteView) {
        stack.append(screen)
    }
    
    func append(with routes: [RouteView]) {
        stack.append(contentsOf: routes)
    }
    
    func replace(with stack: [RouteView]) {
        self.stack = stack
    }
    
    func pop() {
        _ = stack.popLast()
    }
    
    func pop(to: RouteView) {
        guard let indexOfScreen = stack.lastIndex(of: to) else { return }
        
        stack.removeLast(stack.count - 1 - indexOfScreen)
    }
    
    func popToRoot() {
        stack = []
    }
}
