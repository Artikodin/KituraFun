import XCTest
@testable import projet1

class projet1Tests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(projet1().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
