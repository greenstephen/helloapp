import SwiftUI
import AppCore

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, \(AppCore.name)!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
