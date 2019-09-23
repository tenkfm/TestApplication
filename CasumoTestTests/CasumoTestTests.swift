import XCTest
@testable import CasumoTest

class CasumoTestTests: XCTestCase {

    override func setUp() {
        Injection.shared.config()
        
    }

    override func tearDown() {
        
    }

    func testNetworking() {
        let dataSource = Injection.shared.container.resolve(DataSource.self, name: "Mock")
        _ = dataSource?.getEvents().subscribe(onSuccess: { (events) in
            XCTAssertEqual(events.count, 30, "")
        }, onError: { (error) in
            XCTFail(error.localizedDescription)
        })
    }

}
