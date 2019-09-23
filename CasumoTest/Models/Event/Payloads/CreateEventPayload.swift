import Foundation

struct CreateEventPayload: Decodable {
    
    let ref:            String?
    let refType:        String?
    let masterBranch:   String?
    let description:    String?
    let pusherType:     String?
    
    enum CodingKeys: String, CodingKey {
        case ref
        case refType        = "ref_type"
        case masterBranch   = "master_branch"
        case description
        case pusherType     = "pusher_type"
    }
    
}

extension CreateEventPayload: Payload {
    var displayableParams: [String : String?] {
        return ["Ref"           : ref,
                "RefType"       : refType,
                "Master branch" : masterBranch,
                "Description"   : description,
                "pusher type"   : pusherType]
    }
}
