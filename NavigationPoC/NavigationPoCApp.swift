//
//  NavigationPoCApp.swift
//  NavigationPoC
//
//  Created by Mattei, Marco-MIGROSONLINE on 22.08.23.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    var app: NavigationPoCApp?
        
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App did finish launching with options")
        return true
    }
}

struct DIContainer {
    static let appNavState = AppNavigationState.shared
}

@main
struct NavigationPoCApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var appNavigationState = DIContainer.appNavState

    
    var body: some Scene {
        WindowGroup {
            ScrollViewReader { proxy in
                TabView(selection: $appNavigationState.selectedTab) {
                    FirstTabHomeView()
                        .tag(AppNavigationState.AppTab.firstTab)
                        .tabItem {
                            Label("First", systemImage: "tray.and.arrow.down.fill")
                        }
                        .environmentObject(appNavigationState)
                        .environmentObject(appNavigationState.firstTabRouter)
                        .onChange(of: appNavigationState.scrollToTopFirstTab) { shouldScrollToTop in
                            if shouldScrollToTop {
                                withAnimation {
                                    proxy.scrollTo(AppNavigationState.ScrollAnchor.firstTabTop)
                                }
                                appNavigationState.scrollToTopFirstTab = false
                            }
                        }
                    SecondTabHomeView()
                        .tag(AppNavigationState.AppTab.secondTab)
                        .tabItem {
                            Label("Second", systemImage: "tray.and.arrow.up.fill")
                        }
                        .environmentObject(appNavigationState)
                        .environmentObject(appNavigationState.secondTabRouter)
                        .onChange(of: appNavigationState.scrollToTopSecondTab) { _ in
                            withAnimation {
                                proxy.scrollTo(AppNavigationState.ScrollAnchor.secondTabTop)
                            }
                        }
                }
                .mSnackbar(isShowing: $appNavigationState.isSnackbarPresented, message: appNavigationState.snackbarMessage, messageType: .success)
                .fullScreenCover(item: $appNavigationState.presentedFullScreen, content: { route in
                    route
                        .environmentObject(appNavigationState)
                        .mSnackbar(isShowing: $appNavigationState.isSnackbarPresented, message: appNavigationState.snackbarMessage, messageType: .success)
                })
                .sheet(item: $appNavigationState.presentedSheet, content: { route in
                    route
                        .environmentObject(appNavigationState)
                        .mSnackbar(isShowing: $appNavigationState.isSnackbarPresented, message: appNavigationState.snackbarMessage, messageType: .success)
                })
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            appNavigationState.resetAll()
                        } label: {
                            Text("Reset all")
                        }
                    }
                }
                .onOpenURL { url in
                    appNavigationState.handleUrl(url)
                }
            }
        }
    }
}
