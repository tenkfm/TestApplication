import Foundation
import Swinject
import SwinjectStoryboard
import Moya
import Logging

class Injection {
    
    static public let shared = Injection()
    
    ///MARK: Private
    public let container: Container

    private init() {
        container = Container()
        register()
    }
    
    private func register() {
        
        // Logger
        container.register(Logger.self) { _ in
            Logger(label: "com.casumo.test.CasumoTest")
        }
        
        // Networking
        container.register(MoyaProvider.self) { _ in
            MoyaProvider<GitHubTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
        }
        container.register(DataSource.self) { r in
            NetworkingService(provider: r.resolve(MoyaProvider.self)!)
            }.inObjectScope(.container)

        
        container.register(MoyaProvider.self, name: "Mock") { _ in
            MoyaProvider<GitHubTarget>(stubClosure: MoyaProvider.immediatelyStub)
        }
        container.register(DataSource.self, name: "Mock") { r in
            NetworkingService(provider: r.resolve(MoyaProvider.self, name: "Mock")!)
            }.inObjectScope(.container)
        

        // View Controllers
        container.register(EventsViewModel.self) { r in
            EventsViewModel(dataSource: r.resolve(DataSource.self)!)
        }
        container.storyboardInitCompleted(EventsViewController.self) { r, c in
            c.viewModel = r.resolve(EventsViewModel.self)
            c.logger    = r.resolve(Logger.self)
        }
        
        container.register(EventDetailsViewModel.self) { _, event in
            EventDetailsViewModel(event: event)
        }
        container.storyboardInitCompleted(EventDetailsViewController.self) { r, c in
            c.logger    = r.resolve(Logger.self)
        }
        

        
    }
    
    ///MARK: Public
    
    func config() {}
    
    func getViewController(storyboard: String = "Main", name: String) -> UIViewController {
        let sb = SwinjectStoryboard.create(name: storyboard, bundle: nil, container: container)
        return sb.instantiateViewController(withIdentifier: name)
    }
    
    func getEventDetailsView(event: Event) -> UIViewController {
        let eventDetailsView = getViewController(name: "EventDetailsViewController") as! EventDetailsViewController
        eventDetailsView.viewModel = container.resolve(EventDetailsViewModel.self, argument: event)
        return eventDetailsView
    }
    
}
