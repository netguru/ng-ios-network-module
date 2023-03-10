//
//  ReactiveNgNetworkModule.swift
//  Netguru iOS Network Module
//

import Foundation
import Combine
import NgNetworkModuleCore

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

    /// A convenience method allowing to execute an URL request, parse a response and return it as a Publisher.
    ///
    /// - Parameters:
    ///   - urlRequest: an URL request to execute.
    ///   - responseType: an expected response type.
    ///   - decoder: a top level decoder to use.
    /// - Returns: a publisher to subscribe to.
    func performAndDecode<T: Decodable, Coder: TopLevelDecoder>(
        urlRequest: URLRequest,
        responseType: T.Type,
        decoder: Coder = JSONDecoder()
    ) -> any Publisher<T, NetworkError> where Coder.Input == Data {
        perform(urlRequest: urlRequest).handleAndDecode(to: responseType, decoder: decoder)
    }

    /// A convenience method allowing to execute a network request, parse a response and return it as a Publisher.
    ///
    /// - Parameters:
    ///   - request: a network request to execute.
    ///   - responseType: an expected response type.
    ///   - decoder: a top level decoder to use.
    /// - Returns: a publisher to subscribe to.
    func performAndDecode<T: Decodable, Coder: TopLevelDecoder>(
        request: NetworkRequest,
        responseType: T.Type,
        decoder: Coder = JSONDecoder()
    ) -> AnyPublisher<T, NetworkError> where Coder.Input == Data {
        perform(request: request).handleAndDecode(to: responseType, decoder: decoder)
    }
}
