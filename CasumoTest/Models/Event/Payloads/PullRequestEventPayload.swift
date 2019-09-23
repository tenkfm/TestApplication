import Foundation

struct PullRequestEventPayload: Decodable {
    
    let action: String?
    let number: Int?
    
    enum CodingKeys: String, CodingKey {
        case action
        case number
    }
    
}

extension PullRequestEventPayload: Payload {
    var displayableParams: [String : String?] {
        return ["Action"    : action,
                "Number"    : "\(number ?? 0)"]
    }
}
