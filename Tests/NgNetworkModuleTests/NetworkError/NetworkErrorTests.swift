//
//  NetworkErrorTests.swift
//  Netguru iOS Network Module
//

import UIKit
import XCTest

@testable import NgNetworkModule

final class NetworkErrorTest: XCTestCase {

    func test_whenProvidingErrorCode_shouldCreateNetworkErrorOfProperType() {
        XCTAssertEqual(createError(fromCode: 401), NetworkError.unauthorized, "Should convert to proper error")
        XCTAssertEqual(createError(fromCode: 403), NetworkError.forbidden, "Should convert to proper error")
        XCTAssertEqual(createError(fromCode: 404), NetworkError.notFound, "Should convert to proper error")
    }

    func test_whenProvidingInvalidRequestErrorCode_shouldCreateNetworkErrorOfProperType() {
        //  given:
        let fixtureMessage = "fixtureMessage"
        let codesRange = createArray(from: 400, to: 499, excluding: [401, 403, 404])

        //  then:
        for code in codesRange {
            let error = createError(fromCode: code, message: fixtureMessage)
            let expectedError = NetworkError.invalidRequest(code: code, message: fixtureMessage)
            XCTAssertEqual(error, expectedError, "Should convert to proper error")
        }
    }

    func test_whenProvidingServerErrorRequestErrorCode_shouldCreateNetworkErrorOfProperType() {
        //  given:
        let fixtureMessage = "fixtureMessage"
        let codesRange = createArray(from: 500, to: 599)

        //  then:
        for code in codesRange {
            let error = createError(fromCode: code, message: fixtureMessage)
            let expectedError = NetworkError.serverError(code: code, message: fixtureMessage)
            XCTAssertEqual(error, expectedError, "Should convert to proper error")
        }
    }

    func test_whenProvidingCustomErrorCode_shouldCreateNetworkErrorOfProperType() {
        //  given:
        let fixtureMessage = "fixtureMessage"
        let codesRange = createArray(from: 600, to: 1000).shuffled().prefix(100) // Pick random 100 elements

        //  then:
        for code in codesRange {
            let error = createError(fromCode: code, message: fixtureMessage)
            let expectedError = NetworkError.custom(code: code, message: fixtureMessage)
            XCTAssertEqual(error, expectedError, "Should convert to proper error")
        }
    }
}

private extension NetworkErrorTest {

    func createError(fromCode code: Int, message: String? = nil) -> NetworkError? {
        NetworkError(code: code, message: message)
    }

    func createArray(from: Int, to: Int, excluding array: [Int] = []) -> [Int] {
        Array(from...to).filter { !array.contains($0) }
    }
}
