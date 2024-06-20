import SwiftUI
import Combine

protocol TimeStampActorProtocol: Actor, ActorChangesPublisherProtocol, AsyncStreamPublisherProtocol {
    var timeStamp: Date { get }
}

protocol AsyncStreamPublisherProtocol: Actor {
    var streamPublisher: AsyncStream<Date> { get }
}
