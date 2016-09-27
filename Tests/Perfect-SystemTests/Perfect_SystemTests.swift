import XCTest
@testable import Perfect_System

class Perfect_SystemTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Perfect_System().text, "Hello, World!")
    }


    static var allTests : [(String, (Perfect_SystemTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
