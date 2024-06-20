import SwiftUI

@main
struct AsyncStreamTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(TimeStampViewModel(timeStampActor: TimeStampActor()))
        }
    }
}
