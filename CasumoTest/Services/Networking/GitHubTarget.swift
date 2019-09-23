import Foundation
import Moya

enum GitHubTarget {
    case events
}

// MARK: - TargetType Protocol Implementation
extension GitHubTarget: TargetType {
    
    static var evnironmentBaseURL: String {
        switch NetworkingService.environment {
        case .development: return "https://api.github.com"
        }
    }
    
    var baseURL: URL { return URL(string: GitHubTarget.evnironmentBaseURL)! }
    var path: String {
        switch self {
        case .events:
            return "/events"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .events:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .events:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .events:
            guard let path = Bundle.main.path(forResource: "mock_events", ofType: "json") else {  return "".utf8Encoded }
            let content = try? String(contentsOfFile: path)
            return content?.utf8Encoded ?? "".utf8Encoded
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

// MARK: - Helpers
private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
