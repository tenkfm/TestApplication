//
//  CasumoTestUITests.swift
//  CasumoTestUITests
//
//  Created by Anton Rogachevskyi on 23/08/2019.
//

import XCTest

class CasumoTestUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEventTouch() {
        let app = XCUIApplication()
        
        let existsPredicate = NSPredicate(format: "count > 0")
        expectation(for: existsPredicate, evaluatedWith: app.tables.cells, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        
        app.tables.cells.allElementsBoundByIndex.first?.tap()
        app.navigationBars["Event details"].buttons["Events"].tap()
        
        let lazyFilterButton = app.navigationBars["Events"].buttons["Lazy filter"]
        lazyFilterButton.tap()
        
        let filterSheet = app.sheets["Filter"]
        filterSheet.buttons["PushEvent"].tap()
        lazyFilterButton.tap()
        filterSheet.buttons["Remove filter"].tap()

        
    }
    
}
