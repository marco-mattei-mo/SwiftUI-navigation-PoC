//
//  ContentView.swift
//  NavigationPoC
//
//  Created by Mattei, Marco-MIGROSONLINE on 22.08.23.
//

import SwiftUI
import Factory

struct SecondTabHomeView: View {
    @Injected(\.appNavigationController) var appNavigationController

    var body: some View {
        VStack {
            Button {
                appNavigationController.push(to: .secondTabFirstLevel)
            } label: {
                Text("Go to first level")
            }
            
            Button {
                appNavigationController.push(to: .secondTabThirdLevel)
            } label: {
                Text("Go to third level")
            }
            
            Button {
                appNavigationController.append(with: [.secondTabFirstLevel,
                                                      .secondTabSecondLevel,
                                                      .secondTabThirdLevel])
            } label: {
                Text("Go to third level, with navstack")
            }
            
            Button {
                appNavigationController.showAlert(title: "Test alert", message: "Test message", buttons: [AlertButton(title: "OK", action: {
                    print("Action")
                })])
            } label: {
                Text("Show alert")
            }
            
            Button {
                appNavigationController.presentSheet(with: .secondTabFullScreen(isFullScreen: false))
            } label: {
                Text("Sheet")
            }
            .navigationTitle("Second tab home")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct SecondTabHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTabHomeView()
    }
}
