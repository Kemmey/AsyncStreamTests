import SwiftUI

@MainActor class TimeStampViewModel: ObservableObject, ViewModelActorChangesReceiverProtocol {
    func updateState() async {
        timeStamp = await timeStampActor.timeStamp
    }
    
    let timeStampActor: TimeStampActorProtocol
    
    init(timeStampActor: TimeStampActorProtocol) {
        self.timeStampActor = timeStampActor
        Task {
            await subscribeToChanges(changePublisher: timeStampActor)
        }
        Task {
            for await newDate in await timeStampActor.streamPublisher {
                timeStampDirect = newDate
            }
        }
    }
    
    @Published var timeStamp: Date = Date()
    @Published var timeStampDirect: Date = Date()
}
