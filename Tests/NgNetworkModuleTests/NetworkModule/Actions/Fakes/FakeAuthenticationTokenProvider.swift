//
//  FakeAuthenticationTokenProvider.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModule

class FakeAuthenticationTokenProvider: AuthenticationTokenProvider {
    var simulatedAuthenticationToken: String?

    var authenticationToken: String {
        simulatedAuthenticationToken ?? ""
    }
}
