//
//  NetworkModuleAction.swift
//  Netguru iOS Network Module
//

import Foundation

/// An abstraction describing actions to be performed before and / or after the network request is called.
public protocol NetworkModuleAction: AnyObject {

    /// An action to be executed before the network call.
    /// Use to eg. add access token to the outgoing request, etc.
    ///
    /// - Parameters:
    ///   - request: a network request.
    ///   - urlRequest: an URL request.
    func performBeforeExecutingNetworkRequest(request: NetworkRequest?, urlRequest: inout URLRequest)

    /// A request to be executed after the network call.
    /// Use to eg. retrieve a received access token, etc.
    ///
    /// - Parameters:
    ///   - request: a network request.
    ///   - networkResponse: a network response.
    func performAfterExecutingNetworkRequest(request: NetworkRequest?, networkResponse: NetworkResponse)
}

extension NetworkModuleAction {

    /// - SeeAlso: NetworkModuleAction.performBeforeExecutingNetworkRequest(request:urlRequest:)
    public func performBeforeExecutingNetworkRequest(request: NetworkRequest?, urlRequest: inout URLRequest) {}

    /// - SeeAlso: NetworkModuleAction.performAfterExecutingNetworkRequest(request:networkResponse:)
    public func performAfterExecutingNetworkRequest(request: NetworkRequest?, networkResponse: NetworkResponse) {}
}
