//
//  FakeAuthenticationTokenProvider.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModuleCore

final class FakeAuthenticationTokenProvider: AuthenticationTokenProvider {
    var simulatedAuthenticationToken: String?

    var authenticationToken: String {
        simulatedAuthenticationToken ?? ""
    }
}
