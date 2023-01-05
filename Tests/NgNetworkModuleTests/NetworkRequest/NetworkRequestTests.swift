//
//  NetworkRequestTests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest

@testable import NgNetworkModule

final class NetworkRequestTest: XCTestCase {
    var sut: NetworkRequest!

    func test_whenNonEssentialFieldsAreUndefined_shouldUseDefaultImplementation() {
        //  given:
        sut = EmptyNetworkRequest()

        //  then:
        XCTAssertNil(sut.body, "Should not define a request body")
        XCTAssertNil(sut.bodyData, "Should not define a request body data")
        XCTAssertNil(sut.parameters, "Should not define a request parameters")
        XCTAssertFalse(sut.requiresAuthenticationToken, "Should not require authentication token")
        XCTAssertEqual(sut.additionalHeaderFields["Content-Type"], "application/json", "Should define proper Content-Type field")
        XCTAssertEqual(sut.additionalHeaderFields["Accept"], "application/json", "Should define proper Accept field")
        XCTAssertEqual(sut.cachePolicy, .reloadIgnoringCacheData, "Should use no caching policy")
    }

    func test_ifRequestHasBody_shouldEncodeItToData() {
        //  given:
        sut = FakePostNetworkRequest()

        //  when:
        let body = sut.encodedBody

        //  then:
        let decodedBody = body?.decoded(into: FakeRequestBody.self)
        XCTAssertNotNil(decodedBody, "Should decode request body")
        XCTAssertEqual(decodedBody, sut.body as? FakeRequestBody, "Should decode the encoded body")
    }

    func test_ifRequestHasBodyData_shouldUseBodyDataOverEncodableBody() {
        //  given:
        let fixtureBodyContent = "fixtureBodyContent"
        sut = FakePostNetworkRequest(bodyData: fixtureBodyContent.encoded())

        //  when:
        let body = sut.encodedBody

        //  then:
        let decodedBody = body?.decoded(into: String.self)
        XCTAssertNotNil(decodedBody, "Should decode request body")
        XCTAssertEqual(decodedBody, fixtureBodyContent, "Should decode the encoded body")
    }
}
