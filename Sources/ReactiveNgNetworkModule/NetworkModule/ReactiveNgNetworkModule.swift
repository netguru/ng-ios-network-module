//
//  ReactiveNgNetworkModule.swift
//  Netguru iOS Network Module
//

import Foundation
import Combine
import NgNetworkModule

public extension NetworkModule {

    /// A convenience method allowing to execute an URL request and receive response as a Publisher.
    /// - SeeAlso: NetworkResponsePublisher
    ///
    /// - Parameter urlRequest: an URL request to execute.
    /// - Returns: a publisher to subscribe to.
    func perform(urlRequest: URLRequest) -> any Publisher<NetworkResponse, NetworkError> {
        Publishers.NetworkResponsePublisher(urlRequest: urlRequest, networkModule: self)
    }

    /// A convenience method allowing to execute a network request and receive response as a Publisher.
    /// - SeeAlso: NetworkResponsePublisher
    ///
    /// - Parameter request: an network request to execute.
    /// - Returns: a publisher to subscribe to.
    func perform(request: NetworkRequest) -> any Publisher<NetworkResponse, NetworkError> {
        Publishers.NetworkResponsePublisher(request: request, networkModule: self)
    }
}
