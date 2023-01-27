//
//  NetworkResponseTests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest

@testable import NgNetworkModuleCore

final class NetworkResponseTest: XCTestCase {
    private let fakeResponseData = FakeResponseData(fooString: "bar", fooNumber: 1)
    var fixtureHTTPURLResponse: HTTPURLResponse!
    var lastDecodedData: Codable?
    var lastReceivedError: NetworkError?
    var sut: NetworkResponse!

    override func setUp() {
        lastDecodedData = nil
        lastReceivedError = nil
        fixtureHTTPURLResponse = HTTPURLResponse(
            url: URL(string: "https://netguru.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
    }

    func test_whenReceivedNetworkResponseWithValidData_shouldDecodeItToAssociatedItem() {
        //  given:
        sut = NetworkResponse(data: fakeResponseData.encoded(), networkResponse: fixtureHTTPURLResponse)

        //  when:
        decodeResponse(into: FakeResponseData.self)

        //  then:
        XCTAssertEqual(lastDecodedData as? FakeResponseData, fakeResponseData, "Should properly decode received data")
        XCTAssertNil(lastReceivedError, "Should not return an error")
    }

    func test_whenReceivedNetworkResponseWithoutData_shouldReturnProperError() {
        //  given:
        sut = NetworkResponse(data: nil, networkResponse: fixtureHTTPURLResponse)

        //  when:
        decodeResponse(into: FakeResponseData.self)

        //  then:
        XCTAssertNil(lastDecodedData, "Should not be able to decode data")
        XCTAssertEqual(lastReceivedError, NetworkError.noResponseData, "Should return a proper error")
    }

    func test_whenReceivedNetworkResponseWithInvalidData_shouldReturnProperError() {
        //  given:
        sut = NetworkResponse(data: Data(), networkResponse: fixtureHTTPURLResponse)

        //  when:
        decodeResponse(into: FakeResponseData.self)

        //  then:
        XCTAssertNil(lastDecodedData, "Should not be able to decode data")
        XCTAssertEqual(lastReceivedError, NetworkError.responseParsingFailed, "Should return a proper error")
    }
}

private extension NetworkResponseTest {

    func decodeResponse<T: Codable>(into type: T.Type) {
        let decoded = sut.decoded(into: type)
        switch decoded {
        case let .success(decoded):
            lastDecodedData = decoded
        case let .failure(error):
            lastReceivedError = error
        }
    }
}

private struct FakeResponseData: Codable, Equatable {
    let fooString: String
    let fooNumber: Int
}
