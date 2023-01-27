//
//  AuthenticationTokenProvider.swift
//  Netguru iOS Network Module
//

import Foundation

/// An abstraction providing an authentication token.
public protocol AuthenticationTokenProvider {

    /// An authentication token.
    var authenticationToken: String { get }
}

extension String: AuthenticationTokenProvider {

    /// - SeeAlso: AuthenticationTokenProvider.authenticationToken
    public var authenticationToken: String {
        self
    }
}
