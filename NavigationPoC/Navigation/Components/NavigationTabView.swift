import SwiftUI
import Factory

struct NavigationTabView: View {
    @StateObject var appNavigationController = Container.shared.appNavigationController() as! ConcreteAppNavigationController
    let firstTabHomeView = RouteView(route: .firstTabHomeView)
    let secondTabHomeView = RouteView(route: .secondTabHomeView)

    var body: some View {
        ScrollViewReader { proxy in
            TabView(selection: $appNavigationController.selectedTab) {
                MNavigationStack(path: $appNavigationController.firstTabRouter.stack) {
                    firstTabHomeView
                        .onAppear {
                            appNavigationController.firstTabRouter.rootView = firstTabHomeView
                        }
                        .mNavigationDestination(for: RouteView.self) { $0 }
                }
                .tag(AppTab.firstTab)
                .tabItem {
                    Label("First", systemImage: "tray.and.arrow.down.fill")
                }
                .onChange(of: appNavigationController.scrollToTopFirstTab) { shouldScrollToTop in
                    if shouldScrollToTop {
                        withAnimation {
                            proxy.scrollTo(ConcreteAppNavigationController.ScrollAnchor.firstTabTop)
                        }
                        appNavigationController.scrollToTopFirstTab = false
                    }
                }
                MNavigationStack(path: $appNavigationController.secondTabRouter.stack) {
                    secondTabHomeView
                        .onAppear {
                            appNavigationController.secondTabRouter.rootView = secondTabHomeView
                        }
                        .mNavigationDestination(for: RouteView.self) { $0 }
                }
                .tag(AppTab.secondTab)
                .tabItem {
                    Label("Second", systemImage: "tray.and.arrow.up.fill")
                }
                .onChange(of: appNavigationController.scrollToTopSecondTab) { _ in
                    withAnimation {
                        proxy.scrollTo(ConcreteAppNavigationController.ScrollAnchor.secondTabTop)
                    }
                }
            }
        }
    }
}
