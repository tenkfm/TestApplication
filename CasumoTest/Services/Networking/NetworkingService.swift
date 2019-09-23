import Foundation
import Moya
import RxSwift

enum APIEnvironment {
    case development
}

class NetworkingService: DataSource {
    
    static let environment: APIEnvironment = .development
    private let provider: MoyaProvider<GitHubTarget>

    init(provider: MoyaProvider<GitHubTarget>) {
        self.provider = provider
    }
    
    ///MARK -
    
    func getEvents() -> Single<[Event]> {
        return provider.rx
            .request(.events)
            .filterSuccessfulStatusAndRedirectCodes()
            .map([Event].self)
    }
    
}
