import SwiftUI

struct FirstLevelView: View {
    var body: some View {
        MNavigationLink(value: RouteView(route: .secondTabSecondLevel)) {
            Text("Go to second level")
        }
        .navigationTitle("First level")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FirstLevelView_Previews: PreviewProvider {
    static var previews: some View {
        MNavigationStack {
            FirstLevelView()
        }
    }
}
