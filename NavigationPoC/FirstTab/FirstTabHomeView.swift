//
//  ContentView.swift
//  NavigationPoC
//
//  Created by Mattei, Marco-MIGROSONLINE on 22.08.23.
//

import NavigationBackport
import SwiftUI

struct FirstTabHomeView: View {
    @EnvironmentObject var appNavState: AppNavigationState
    @EnvironmentObject var router: Router
    
    var body: some View {
        NBNavigationStack(path: $router.stack) {
            ScrollView {
                Text("Header")
                .id(AppNavigationState.ScrollAnchor.firstTabTop)
                LazyVStack(alignment: .leading) {
                    ForEach(0..<20) { item in
                        NBNavigationLink(value: Route.itemDetails(id: item)) {
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
            .nbNavigationDestination(for: Route.self) { $0 }
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
