//
//  NetworkErrorTests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest

@testable import NgNetworkModule

final class NetworkErrorTest: XCTestCase {

    func test_whenProvidingErrorCode_shouldCreateNetworkErrorOfProperType() {
        XCTAssertEqual(createError(fromCode: 401), NetworkError.unauthorized, "Should convert to proper error")
        XCTAssertEqual(createError(fromCode: 403), NetworkError.forbidden, "Should convert to proper error")
        XCTAssertEqual(createError(fromCode: 403), NetworkError.forbidden, "Should convert to proper error")
        XCTAssertEqual(createError(fromCode: -999), NetworkError.cancelled, "Should convert to proper error")
    }

    func test_whenProvidingInvalidErrorCode_shouldNotCreateNetworkError() {
        //  given:
        let codesRange = createArray(from: 200, to: 399)

        //  then:
        for code in codesRange {
            let error = createError(fromCode: code, message: nil)
            XCTAssertNil(error, "Should not create an error")
        }
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
    
    func test_convertingNSError_shouldReturnProperNetworkError() {
        //  given:
        let fixtureCode = 408
        let fixtureNSError = NSError(domain: "", code: fixtureCode, userInfo: nil)
        
        //  when:
        let error = NetworkError(error: fixtureNSError)
        
        //  then:
        let expectedError = NetworkError.invalidRequest(code: fixtureCode, message: fixtureNSError.localizedDescription)
        XCTAssertEqual(error, expectedError, "Should convert to proper error")
    }

    func test_convertingUrlResponseWithError_shouldReturnProperNetworkError() {
        //  given:
        let fixtureResponse = HTTPURLResponse(url: URL(string: "https://ng.com")!, statusCode: 401, httpVersion: nil, headerFields: nil)

        //  when:
        let error = NetworkError(urlResponse: fixtureResponse!)

        //  then:
        XCTAssertEqual(error, NetworkError.unauthorized, "Should convert to proper error")
    }

    func test_convertingUrlResponseWithoutError_shouldNotReturnNetworkError() {
        //  given:
        let fixtureResponse = HTTPURLResponse(url: URL(string: "https://ng.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        //  when:
        let error = NetworkError(urlResponse: fixtureResponse!)

        //  then:
        XCTAssertNil(error, "Should return no error")
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
