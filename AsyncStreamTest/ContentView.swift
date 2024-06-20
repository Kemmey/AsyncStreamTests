import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: TimeStampViewModel
    
    var body: some View {
        VStack {
            Text("Using actor changes publisher:").foregroundStyle(.secondary)
            Text(viewModel.timeStamp, format: Date.FormatStyle(date: .omitted, time: .standard))
            Text("Using direct stream publisher:").foregroundStyle(.secondary)
            Text(viewModel.timeStampDirect, format: Date.FormatStyle(date: .omitted, time: .standard))
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(TimeStampViewModel(timeStampActor: TimeStampActor()))
}
