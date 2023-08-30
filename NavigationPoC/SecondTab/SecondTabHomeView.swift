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
                appNavigationController.navigateToSecondTabFirstLevel()
            } label: {
                Text("Go to first level")
            }
            
            Button {
                appNavigationController.navigateToSecondTabThirdLevel(includeNavstack: false)
            } label: {
                Text("Go to third level")
            }
            
            Button {
                appNavigationController.navigateToSecondTabThirdLevel(includeNavstack: true)
            } label: {
                Text("Go to third level, with navstack")
            }
            
            Button {
                appNavigationController.presentSecondTabAsSheet()
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
