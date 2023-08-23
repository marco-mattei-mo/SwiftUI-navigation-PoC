import SwiftUI

struct FirstLevelView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        MNavigationLink(value: Route.secondTabSecondLevel) {
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
                .environmentObject(Router())
        }
    }
}
