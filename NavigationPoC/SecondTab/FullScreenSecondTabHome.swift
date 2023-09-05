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
    @Environment(\.dismiss) var dismiss
    
    let isFullScreen: Bool

    var body: some View {
            SecondTabHomeView()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // Either use "dismiss" env key or use appNavController
                        
                        dismiss()
//                        if isFullScreen {
//                            appNavigationController.dismissFullScreenCover()
//                        } else {
//                            appNavigationController.dismissSheet()
//                        }
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
        FullScreenSecondTabHomeView(isFullScreen: true)
    }
}
