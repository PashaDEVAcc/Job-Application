
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginCreateAccountView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
