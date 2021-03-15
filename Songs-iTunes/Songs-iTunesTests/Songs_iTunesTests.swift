import XCTest

@testable import Songs_iTunes

class Songs_iTunesTests: XCTestCase {

    func testExample() throws {
        let viewController = SearchViewController()
        XCTAssertEqual(viewController.arraySearchTerms.count, 6, "arraySearchTerms correct");
    }

}
