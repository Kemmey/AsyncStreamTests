import Foundation
import Combine

protocol ActorChangesPublisherProtocol: Actor, AnyObject {
    var changesSubject: PassthroughSubject<Void, Never> { get }
    var hasChangesPublisher: AsyncStream<Void> { get }
    func notifyChanges()
}

extension ActorChangesPublisherProtocol {
    var hasChangesPublisher: AsyncStream<Void> {
        AsyncStream { continuation in
            Task {
                for await _ in changesSubject.values {
                    continuation.yield(())
                }
                continuation.finish()
            }
        }
    }
    
    func notifyChanges() {
        changesSubject.send(())
    }
}
