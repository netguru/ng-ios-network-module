//
//  BackgroundQueueOperationsExecutorTests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest

@testable import NgNetworkModuleCore

final class BackgroundQueueOperationsExecutorTest: XCTestCase {
    var sut: BackgroundQueueOperationsExecutor!

    override func setUp() {
        sut = BackgroundQueueOperationsExecutor()
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
        XCTAssertEqual(sut.type, AsynchronousExecutorType.backgroundConcurrent, "Should be of proper type")
        XCTAssertEqual(didExecuteCallback, true, "Should execute callback")
    }
}
