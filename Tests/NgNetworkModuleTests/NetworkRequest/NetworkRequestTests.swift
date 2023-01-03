//
//  NetworkRequestTests.swift
//  Netguru iOS Network Module
//

import UIKit
import XCTest

@testable import NgNetworkModule

final class NetworkRequestTest: XCTestCase {
    var sut: NetworkRequest!

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
        sut = FakePostNetworkRequestWithDataBody()

        //  when:
        let body = sut.encodedBody

        //  then:
        let decodedBody = body?.decoded(into: String.self)
        XCTAssertNotNil(decodedBody, "Should decode request body")
        XCTAssertEqual(decodedBody, FakePostNetworkRequestWithDataBody.FIXTURE_BODY_CONTENT, "Should decode the encoded body")
    }
}
