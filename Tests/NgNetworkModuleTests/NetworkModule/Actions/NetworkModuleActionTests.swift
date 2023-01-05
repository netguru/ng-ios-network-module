//
//  NetworkModuleActionTests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest

@testable import NgNetworkModule

final class NetworkModuleActionTest: XCTestCase {
    var sut: NetworkModuleAction!

    override func setUp() {
        sut = EmptyNetworkModuleAction()
    }

    func test_whenExecuted_shouldNotChangeOutgoingRequest() {
        //  given:
        let fakeRequest = FakeGetNetworkRequest(path: "/welcome")
        let fixtureUrl = URL(string: "https://netguru.com")!
        let fixtureResponse = NetworkResponse(
            data: nil,
            networkResponse: HTTPURLResponse(
                url: fixtureUrl,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
        )
        var fixtureUrlRequest = URLRequest(url: fixtureUrl)
        let fixtureOriginalUrlRequest = fixtureUrlRequest

        //  when:
        sut.performBeforeExecutingNetworkRequest(request: fakeRequest, urlRequest: &fixtureUrlRequest)
        sut.performAfterExecutingNetworkRequest(request: fakeRequest, networkResponse: fixtureResponse)

        //  then:
        XCTAssertEqual(fixtureOriginalUrlRequest, fixtureUrlRequest, "Should not change the original request")
    }
}

private final class EmptyNetworkModuleAction: NetworkModuleAction {}
