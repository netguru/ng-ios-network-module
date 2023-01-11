//
//  NetworkErrorConvertibleTests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest

@testable import NgNetworkModule

final class NetworkErrorConvertibleTest: XCTestCase {
    var sut: NetworkErrorConvertible!

    func test_whenProvidedWithCorrectErrorCodeAndMessage_shouldCreateProperNetworkError() {
        //  given:
        let fixtureStatusCode = 480
        let fixtureMessage = "fixtureMessage"

        //  when:
        sut = fixtureStatusCode
        let error = sut.toNetworkError(message: fixtureMessage)

        //  then:
        XCTAssertEqual(error, NetworkError.invalidRequest(code: fixtureStatusCode, message: fixtureMessage), "Should create proper error")
    }

    func test_whenProvidedWithIncorrectErrorCode_shouldNotCreateNetworkError() {
        //  given:
        let fixtureStatusCode = 200

        //  when:
        sut = fixtureStatusCode
        let error = sut.toNetworkError()

        //  then:
        XCTAssertNil(error, "Should not create an error")
    }
}
