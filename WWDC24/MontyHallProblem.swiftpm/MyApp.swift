import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MenuView()
                .preferredColorScheme(.light)
                .ignoresSafeArea()
        }
    }
}
