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
    @Injected(\.appNavigationController) private var appNavigationController
    
    var body: some Scene {
        WindowGroup {
            NavigationTabView()
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
