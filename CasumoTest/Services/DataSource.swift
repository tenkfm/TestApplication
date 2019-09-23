import Foundation
import RxSwift

protocol DataSource {
    
    func getEvents() -> Single<[Event]>
    
}
