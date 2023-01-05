//
//  AddAuthenticationTokenNetworkModuleAction.swift
//  Netguru iOS Network Module
//

import Foundation

/// A network module action adding authentication header to an outgoing request.
public final class AddAuthenticationTokenNetworkModuleAction: NetworkModuleAction {

    /// An authentication token provider.
    let authenticationTokenProvider: AuthenticationTokenProvider

    /// an authentication token header field name.
    let authenticationTokenHeaderFieldName: String

    /// A default initializer for AddAuthenticationTokenNetworkModuleAction.
    ///
    /// - Parameter authenticationTokenProvider: an authentication token provider.
    /// - Parameter authenticationTokenHeaderFieldName: an authentication token header filed name.
    public init(
        authenticationTokenProvider: AuthenticationTokenProvider,
        authenticationTokenHeaderFieldName: String
    ) {
        self.authenticationTokenProvider = authenticationTokenProvider
        self.authenticationTokenHeaderFieldName = authenticationTokenHeaderFieldName
    }

    /// - SeeAlso: AddJsonContentTypeNetworkModuleAction.performBeforeExecutingNetworkRequest(request:urlRequest:)
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
