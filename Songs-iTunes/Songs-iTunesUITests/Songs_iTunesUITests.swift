import XCTest

class Songs_iTunesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws { }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
                
        let elementsQuery = XCUIApplication().scrollViews.otherElements
        
        let seaChip = elementsQuery.buttons["Sea"]
        let waterChip = elementsQuery.buttons["Water"]
        let top100Chip = elementsQuery.buttons["Top 100"]

        seaChip.tap()
        
        XCTAssertFalse(top100Chip.isSelected)
        XCTAssertFalse(waterChip.isSelected)
        XCTAssertTrue(seaChip.isSelected)
        
        waterChip.tap()
        
        XCTAssertFalse(top100Chip.isSelected)
        XCTAssertTrue(waterChip.isSelected)
        XCTAssertFalse(seaChip.isSelected)
        
        top100Chip.tap()
        
        XCTAssertTrue(top100Chip.isSelected)
        XCTAssertFalse(waterChip.isSelected)
        XCTAssertFalse(seaChip.isSelected)
 
    }
    
}
