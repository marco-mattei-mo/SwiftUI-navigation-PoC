import SwiftUI

struct FirstLevelView: View {
    @EnvironmentObject var router: Router<SecondTabRoute>

    var body: some View {
        MNavigationLink(value: SecondTabRoute.secondTabSecondLevel) {
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
                .environmentObject(Router<SecondTabRoute>())
        }
    }
}
