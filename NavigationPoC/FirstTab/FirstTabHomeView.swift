//
//  ContentView.swift
//  NavigationPoC
//
//  Created by Mattei, Marco-MIGROSONLINE on 22.08.23.
//

import SwiftUI

struct FirstTabHomeView: View {
    @EnvironmentObject var appNavState: AppNavigationState
    @EnvironmentObject var router: Router
    
    var body: some View {
        MNavigationStack(path: $router.stack) {
            ScrollView {
                Text("Header")
                .id(AppNavigationState.ScrollAnchor.firstTabTop)
                LazyVStack(alignment: .leading) {
                    ForEach(0..<20) { item in
                        MNavigationLink(value: Route.itemDetails(id: item)) {
                            Text("Item: \(item)")
                                .id(UUID())
                                .padding(8)
                        }
                        Divider()
                    }
                }
                Divider()
                    .padding(.bottom, 32)
                Button {
                    router.push(to: .info)
                } label: {
                    Text("Info")
                }
                .padding(.bottom, 32)
                
                Button {
                    appNavState.presentFullScreenCover(screen: .secondTabFullScreen)
                } label: {
                    Text("Fullscreen cover")
                }
                
            }
            .mNavigationDestination(for: Route.self) { $0 }
            .navigationTitle("First level")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FirstTabHomeView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTabHomeView()
            .environmentObject(Router())
    }
}
