//
//  AuthenticationTokenProviderTests.swift
//  Netguru iOS Network Module
//

import UIKit
import XCTest

@testable import NgNetworkModule

final class AuthenticationTokenProviderTest: XCTestCase {
    var sut: AuthenticationTokenProvider!

    func test_passingStringAsAuthenticationTokenProvider() {
        //  given:
        let fixtureToken = "fixtureToken"

        //  when:
        sut = fixtureToken

        //  then:
        XCTAssertEqual(sut.authenticationToken, fixtureToken, "Should provide its own value as token")
    }
}
