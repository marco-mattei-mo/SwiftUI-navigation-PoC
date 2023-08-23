import SwiftUI

struct SecondLevelView: View {
    @EnvironmentObject var router: Router<SecondTabRoute>

    var body: some View {
        MNavigationLink(value: SecondTabRoute.secondTabThirdLevel) {
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
                .environmentObject(Router<SecondTabRoute>())
        }
    }
}
