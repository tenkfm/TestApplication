struct Repo: Decodable {
    
    let id:     Int
    let name:   String
    let url:    String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
    }
}
