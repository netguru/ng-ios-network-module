//
//  NetworkRequestTypeTests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest

@testable import NgNetworkModuleCore

final class NetworkRequestTypeTest: XCTestCase {

    func test_everyNetworkRequestType_shouldReturnProperValue() {
        //  given:
        let fixtureType1 = "fixtureType1"
        let fixtureType2 = "fixtureType2"
        let requestTypes = [
            NetworkRequestType.delete, .get, .patch, .post, .put, .custom(fixtureType1), .custom(fixtureType2)
        ]
        let expectedValues = [
            "delete", "get", "patch", "post", "put", fixtureType1, fixtureType2
        ]

        //  then:
        for (index, expectedValue) in expectedValues.enumerated() {
            let requestType = requestTypes[index]
            XCTAssertEqual(requestType.value, expectedValue, "Type \(requestType) should return \(expectedValue) value")
        }
    }
}
