import Factory

extension Container {
    var appNavigationController: Factory<any AppNavigationController> {
        (self) { ConcreteAppNavigationController() }
            .singleton
    }
}
