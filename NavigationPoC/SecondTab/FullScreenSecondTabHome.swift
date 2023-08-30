//
//  ContentView.swift
//  NavigationPoC
//
//  Created by Mattei, Marco-MIGROSONLINE on 22.08.23.
//

import SwiftUI
import Factory

struct FullScreenSecondTabHomeView: View {
    @Injected(\.appNavigationController) var appNavigationController
    
    var body: some View {
            SecondTabHomeView()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        appNavigationController.dismissCoverAndSheet()
                    } label: {
                        Text("Close")
                    }
                    
                }
            }
            .navigationTitle("Second tab home")
            .navigationBarTitleDisplayMode(.inline)
        }
        
}

struct FullScreenSecondTabHomeView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenSecondTabHomeView()
    }
}
