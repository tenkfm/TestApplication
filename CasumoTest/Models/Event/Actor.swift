struct Actor: Decodable {

    let id:             Int
    let login:          String
    let displayLogin:   String
    let url:            String
    let avatarUrl:      String


    enum CodingKeys: String, CodingKey {
        case id
        case login
        case displayLogin   = "display_login"
        case url
        case avatarUrl      = "avatar_url"
    }
}
