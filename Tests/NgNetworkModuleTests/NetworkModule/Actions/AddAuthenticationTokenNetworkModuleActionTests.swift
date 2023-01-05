//
//  AddAuthenticationTokenNetworkModuleActionTests.swift
//  Netguru iOS Network Module
//

import Foundation
import XCTest

@testable import NgNetworkModule

final class AddAuthenticationTokenNetworkModuleActionTest: XCTestCase {
    let fixtureAuthenticationTokenHeaderFieldName = "Authentication"
    var fakeAuthenticationTokenProvider: FakeAuthenticationTokenProvider!
    var sut: AddAuthenticationTokenNetworkModuleAction!

    override func setUp() {
        fakeAuthenticationTokenProvider = FakeAuthenticationTokenProvider()
        sut = AddAuthenticationTokenNetworkModuleAction(
            authenticationTokenProvider: fakeAuthenticationTokenProvider,
            authenticationTokenHeaderFieldName: fixtureAuthenticationTokenHeaderFieldName
        )
    }

    func test_whenExecutedWithRequestRequiringAuthentication_shouldAddAccessTokenValueAsHeaderField() {
        //  given:
        let fixtureAuthenticationToken = "AuthToken"
        let fakeRequest = FakeGetNetworkRequest(path: "/welcome", requiresAuthenticationToken: true)
        var fixtureUrlRequest = URLRequest(url: URL(string: "https://netguru.com/")!)
        fakeAuthenticationTokenProvider.simulatedAuthenticationToken = fixtureAuthenticationToken

        //  when:
        sut.performBeforeExecutingNetworkRequest(request: fakeRequest, urlRequest: &fixtureUrlRequest)

        //  then:
        let authenticationFieldValue = fixtureUrlRequest.allHTTPHeaderFields?[fixtureAuthenticationTokenHeaderFieldName]
        XCTAssertEqual(authenticationFieldValue, fixtureAuthenticationToken, "Should contain proper header field")
    }

    func test_whenExecutedWithRequestNotRequiringAuthentication_shouldNotAddAccessTokenValueAsHeaderField() {
        //  given:
        let fixtureAuthenticationToken = "AuthToken"
        let fakeRequest = FakeGetNetworkRequest(path: "/welcome", requiresAuthenticationToken: false)
        var fixtureUrlRequest = URLRequest(url: URL(string: "https://netguru.com/")!)
        let initialUrlRequest = fixtureUrlRequest
        fakeAuthenticationTokenProvider.simulatedAuthenticationToken = fixtureAuthenticationToken

        //  when:
        sut.performBeforeExecutingNetworkRequest(request: fakeRequest, urlRequest: &fixtureUrlRequest)

        //  then:
        XCTAssertEqual(initialUrlRequest, fixtureUrlRequest, "Should not modify the request")
    }
}
