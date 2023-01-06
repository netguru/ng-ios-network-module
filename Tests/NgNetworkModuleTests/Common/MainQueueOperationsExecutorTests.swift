import Foundation
import XCTest

@testable import NgNetworkModule

final class MainQueueOperationsExecutorTest: XCTestCase {
    var sut: MainQueueOperationsExecutor!

    override func setUp() {
        sut = MainQueueOperationsExecutor()
    }

    func test_shouldExecuteProvidedCallbackAsynchronously() {
        //  given:
        let fixtureExpectation = XCTestExpectation(description: "Execute a callback")
        var didExecuteCallback: Bool?
        
        //  when:
        sut.execute {
            didExecuteCallback = true
            fixtureExpectation.fulfill()
        }

        //  then:
        wait(for: [fixtureExpectation], timeout: 1.0)
        XCTAssertEqual(sut.type, AsynchronousExecutorType.main, "Should be of proper type")
        XCTAssertEqual(didExecuteCallback, true, "Should execute callback")
    }
}
