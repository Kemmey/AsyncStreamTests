import Foundation
import Combine

@MainActor
protocol ViewModelActorChangesReceiverProtocol: ObservableObject {
    func subscribeToChanges(changePublisher: ActorChangesPublisherProtocol) async
    func updateState() async
}

extension ViewModelActorChangesReceiverProtocol {
    func subscribeToChanges(changePublisher: ActorChangesPublisherProtocol) async {
        for await _ in await changePublisher.hasChangesPublisher {
            await updateState()
        }
    }
}
