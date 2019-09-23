import Foundation

struct PushEventPayload: Decodable {
    
    let pushId: Int?
    let size:   Int?
    let ref:    String?
    let head:   String?
    let before: String?
    
    enum CodingKeys: String, CodingKey {
        case pushId = "push_id"
        case size
        case ref
        case head
        case before
    }
    
}

extension PushEventPayload: Payload {
    var displayableParams: [String : String?] {
        
        return ["Push id"   : "\(pushId ?? 0)",
                "Size"      : "\(size ?? 0)",
                "Ref"       : ref,
                "Head"      : head,
                "Before"    : before]
    }
    
}
