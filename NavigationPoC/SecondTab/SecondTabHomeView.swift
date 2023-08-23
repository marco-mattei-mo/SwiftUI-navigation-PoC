//
//  ContentView.swift
//  NavigationPoC
//
//  Created by Mattei, Marco-MIGROSONLINE on 22.08.23.
//

import SwiftUI

struct SecondTabHomeView: View {
    @EnvironmentObject var appNavState: AppNavigationState
    @EnvironmentObject var router: Router
    
    var body: some View {
        MNavigationStack(path: $router.stack) {
            VStack {
                MNavigationLink(value: Route.secondTabFirstLevel) {
                    Text("Go to first level")
                }
                
                Button {
                    router.push(to: .secondTabThirdLevel)
                } label: {
                    Text("Go to third level")
                }
                
                Button {
                    router.replace(with: [.secondTabFirstLevel, .secondTabSecondLevel, .secondTabThirdLevel])
                } label: {
                    Text("Go to third level, with navstack")
                }
                
                Button {
                    appNavState.presentSheet(screen: .secondTabFullScreen)
                } label: {
                    Text("Sheet")
                }

            }
            .navigationTitle("Second tab home")
            .navigationBarTitleDisplayMode(.inline)
            .mNavigationDestination(for: Route.self) { $0 }
        }
        
    }
}

struct SecondTabHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTabHomeView()
            .environmentObject(AppNavigationState())
            .environmentObject(Router())
    }
}
