import SwiftUI
import NavigationBackport

struct FirstLevelView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        NBNavigationLink(value: Route.secondTabSecondLevel) {
            Text("Go to second level")
        }
        .navigationTitle("First level")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FirstLevelView_Previews: PreviewProvider {
    static var previews: some View {
        NBNavigationStack {
            FirstLevelView()
                .environmentObject(Router())
        }
    }
}
