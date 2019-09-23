import Foundation

class PayloadFactory {
    
    static func create(decoder: Decoder, type: EventType) throws -> Payload? {
        let container = try decoder.container(keyedBy: Event.CodingKeys.self)
        switch type {
        case .pushEvent:
            return try container.decode(PushEventPayload.self, forKey: .payload)
        case .createEvent:
            return try container.decode(CreateEventPayload.self, forKey: .payload)
        case .pullRequestEvent:
            return try container.decode(PullRequestEventPayload.self, forKey: .payload)
        default:
            return nil
        }
    }
    
}
