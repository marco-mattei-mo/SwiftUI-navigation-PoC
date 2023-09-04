//
//  NavigationPoCApp.swift
//  NavigationPoC
//
//  Created by Mattei, Marco-MIGROSONLINE on 22.08.23.
//

import SwiftUI
import Factory

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    var app: NavigationPoCApp?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App did finish launching with options")
        return true
    }
}

@main
struct NavigationPoCApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var appNavigationController = Container.shared.appNavigationController() as! ConcreteAppNavigationController
    
    let firstTabHomeView = RouteView(route: .firstTabHomeView)
    let secondTabHomeView = RouteView(route: .secondTabHomeView)
    
    var body: some Scene {
        WindowGroup {
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
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            appNavigationController.resetAll()
                        } label: {
                            Text("Reset all")
                        }
                    }
                }
                .onOpenURL { url in
                    appNavigationController.handleUrl(url)
                }
            }
        }
    }
}
