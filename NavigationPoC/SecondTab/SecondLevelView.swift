import SwiftUI

struct SecondLevelView: View {
    
    @State var rectangleColor = Color.red

    var body: some View {
        VStack(spacing: 16) {
            MNavigationLink(value: RouteView(route: .secondTabThirdLevel)) {
                Text("Go to third level")
            }
            
            Rectangle()
                .frame(height: 120)
                .foregroundColor(rectangleColor)
            
            Button {
                rectangleColor = Color.random
            } label: {
                Text("Change rectangle color")
            }

            
        }
        .navigationTitle("Second level")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct SecondLevelView_Previews: PreviewProvider {
    static var previews: some View {
        MNavigationStack {
            SecondLevelView()
        }
    }
}
