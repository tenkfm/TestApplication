import RxSwift
import Moya

class EventsViewModel {
    
    private let dataSource: DataSource
    
    var events: [Event]? {
        didSet {
            self.filteredEvents = self.events
        }
    }
    var filteredEvents: [Event]?
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func fetchEvents() -> Completable {
        events = nil
        return .create { observer in
            self.dataSource.getEvents()
                .subscribe(onSuccess: { (events) in
                    self.events = events
                    observer(.completed)
                }, onError: { (error) in
                    print(error)
                    observer(.error(error))
                })
        }
    }
    
    func filter(type: EventType?) {
        if let type = type {
            filteredEvents = events?.filter({
                $0.type == type
            })
        } else {
            filteredEvents = events
        }
    }
}

