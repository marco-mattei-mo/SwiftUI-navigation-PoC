import SwiftUI

struct SecondLevelView: View {

    var body: some View {
        MNavigationLink(value: RouteView(route: .secondTabThirdLevel)) {
            Text("Go to third level")
        }
        .navigationTitle("Second level")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SecondLevelView_Previews: PreviewProvider {
    static var previews: some View {
        MNavigationStack {
            SecondLevelView()
        }
    }
}
