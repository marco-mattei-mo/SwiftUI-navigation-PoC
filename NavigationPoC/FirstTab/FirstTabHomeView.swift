//
//  ContentView.swift
//  NavigationPoC
//
//  Created by Mattei, Marco-MIGROSONLINE on 22.08.23.
//

import SwiftUI
import Factory

struct FirstTabHomeView: View {
    @Injected(\.appNavigationController) var appNavigationController

    var body: some View {
        ScrollView {
            Text("Header")
                .id(ConcreteAppNavigationController.ScrollAnchor.firstTabTop)
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
                appNavigationController.navigateToInfo()
            } label: {
                Text("Info")
            }
            .padding(.bottom, 32)
            
            Button {
                appNavigationController.presentSecondTabAsFullScreen()
            } label: {
                Text("Fullscreen cover")
            }
            .navigationTitle("First level")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct FirstTabHomeView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTabHomeView()
    }
}
