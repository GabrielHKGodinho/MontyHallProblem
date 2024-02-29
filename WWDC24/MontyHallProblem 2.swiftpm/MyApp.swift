import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MenuView(playSong: true)
                .preferredColorScheme(.light)
                .ignoresSafeArea()
        }
    }
}
