import SwiftDate

enum EventType: String, CaseIterable {
    case pushEvent          = "PushEvent"
    case createEvent        = "CreateEvent"
    case pullRequestEvent   = "PullRequestEvent"
    case unknown            = "Unknown"
    
    func createPayload() {
        
    }
}

struct Event: Decodable {
    
    var id:         String
    var rawType:    String
    var type:       EventType
    var isPublic:   Bool
    var createdAt:  Date
    var actor:      Actor
    var repo:       Repo
    let payload:    Payload?
    

    enum CodingKeys: String, CodingKey {
        case id
        case rawType    = "type"
        case isPublic   = "public"
        case createdAt  = "created_at"
        case actor
        case repo
        case payload
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id          = try container.decode(String.self, forKey: .id)
        rawType     = try container.decode(String.self, forKey: .rawType)
        type        = EventType(rawValue: rawType) ?? .unknown
        isPublic    = try container.decode(Bool.self, forKey: .isPublic)
        createdAt   = try container.decode(String.self, forKey: .createdAt).toDate()!.date
        actor       = try container.decode(Actor.self, forKey: .actor)
        repo        = try container.decode(Repo.self, forKey: .repo)
        payload     = try PayloadFactory.create(decoder: decoder, type: type)
    }
    
}
