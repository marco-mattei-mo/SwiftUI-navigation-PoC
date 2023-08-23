//
//  ItemDetailsView.swift
//  NavigationPoC
//
//  Created by Mattei, Marco-MIGROSONLINE on 22.08.23.
//

import SwiftUI

struct ItemDetailsView: View {
    let id: Int
    
    var body: some View {
        Text("Item \(id)")
    }
}

struct ItemDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailsView(id: 1)
    }
}
