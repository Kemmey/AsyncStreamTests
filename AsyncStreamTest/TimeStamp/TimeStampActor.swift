import SwiftUI
import Combine

actor TimeStampActor: TimeStampActorProtocol {
    let changesSubject = PassthroughSubject<Void, Never>()
    
    private(set) var timeStamp: Date = Date()
    private var timerCancellable: AnyCancellable?
    
    init() {
        Task {
            await startTimer()
        }
    }
    
    func startTimer() async {
        await updateTimeStamp()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                Task {
                    await self.updateTimeStamp()
                    await self.send(date: self.timeStamp)
                }
            }
    }
    
    func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    func updateTimeStamp() async {
        timeStamp = Date()
        notifyChanges()
    }
    
    
    
    
    //Direct asyncstream publisher:
    private var continuation: AsyncStream<Date>.Continuation?
    
    // Initialize the AsyncStream
    var streamPublisher: AsyncStream<Date> {
        AsyncStream { continuation in
            self.continuation = continuation
        }
    }
    
    // Function to send a new Date value
    func send(date: Date) {
        continuation?.yield(date)
    }
    
    // Function to finish the stream
    func finish() {
        continuation?.finish()
    }
}
