import SwiftUI
import NavigationBackport

struct SecondLevelView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        NBNavigationLink(value: Route.secondTabThirdLevel) {
            Text("Go to third level")
        }
        .navigationTitle("Second level")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SecondLevelView_Previews: PreviewProvider {
    static var previews: some View {
        NBNavigationStack {
            SecondLevelView()
                .environmentObject(Router())
        }
    }
}
