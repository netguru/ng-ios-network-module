//
//  AddAuthenticationTokenNetworkModuleAction.swift
//  Netguru iOS Network Module
//

import Foundation

/// A network module action adding authentication header to an outgoing request.
public final class AddAuthenticationTokenNetworkModuleAction: NetworkModuleAction {
    private let authenticationTokenProvider: AuthenticationTokenProvider
    private let authenticationTokenHeaderFieldName: String

    /// A default initializer for AddAuthenticationTokenNetworkModuleAction.
    ///
    /// - Parameter authenticationTokenProvider: an authentication token provider.
    /// - Parameter authenticationTokenHeaderFieldName: an authentication token header field name.
    public init(
        authenticationTokenProvider: AuthenticationTokenProvider,
        authenticationTokenHeaderFieldName: String
    ) {
        self.authenticationTokenProvider = authenticationTokenProvider
        self.authenticationTokenHeaderFieldName = authenticationTokenHeaderFieldName
    }

    /// - SeeAlso: NetworkModuleAction.performBeforeExecutingNetworkRequest(request:urlRequest:)
    public func performBeforeExecutingNetworkRequest(request: NetworkRequest?, urlRequest: inout URLRequest) {
        guard request?.requiresAuthenticationToken == true else {
            return
        }

        let authenticationToken = authenticationTokenProvider.authenticationToken
        var headerFields = urlRequest.allHTTPHeaderFields ?? [:]
        headerFields[authenticationTokenHeaderFieldName] = authenticationToken
        urlRequest.allHTTPHeaderFields = headerFields
    }
}
