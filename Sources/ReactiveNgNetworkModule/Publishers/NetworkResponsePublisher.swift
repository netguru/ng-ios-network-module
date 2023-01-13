//
//  NetworkResponsePublisher.swift
//  Netguru iOS Network Module
//

import Foundation
import Combine
import NgNetworkModule

public extension Publishers {

    /// A Publisher allowing to execute an URLRequest using a provided NetworkModule.
    struct NetworkResponsePublisher: Publisher {

        /// A Publisher output type.
        public typealias Output = NetworkResponse

        /// A Publisher failure type.
        public typealias Failure = NetworkError

        private let networkModule: NetworkModule
        private let urlRequest: URLRequest?
        private let networkRequest: NetworkRequest?

        /// A default NetworkResponsePublisher initializer.
        /// To be used to execute a generic URLRequest.
        ///
        /// - Parameters:
        ///   - urlRequest: a URL request to execute.
        ///   - networkModule: a network module executing the request.
        init(urlRequest: URLRequest, networkModule: NetworkModule) {
            self.urlRequest = urlRequest
            self.networkModule = networkModule
            networkRequest = nil
        }

        /// A supplementary NetworkResponsePublisher initializer.
        /// To be used to execute a NetworkRequest.
        ///
        /// - Parameters:
        ///   - request: a network request to execute.
        ///   - networkModule: a network module executing the request.
        init(request: NetworkRequest, networkModule: NetworkModule) {
            self.networkModule = networkModule
            networkRequest = request
            urlRequest = nil
        }

        /// - SeeAlso: Publisher.receive(subscriber:)
        public func receive<S: Subscriber>(subscriber: S)
            where NetworkResponsePublisher.Failure == S.Failure, NetworkResponsePublisher.Output == S.Input {
            guard let subscription = composeSubscription(subscriber: subscriber) else {
                return
            }
            subscriber.receive(subscription: subscription)
        }
    }
}

private extension Publishers.NetworkResponsePublisher {

    func composeSubscription<S: Subscriber>(subscriber: S) -> Publishers.NetworkResponseSubscription<S>? {
        if let urlRequest = urlRequest {
            return Publishers.NetworkResponseSubscription(
                urlRequest: urlRequest,
                networkModule: networkModule,
                subscriber: subscriber
            )
        } else if let networkRequest = networkRequest {
            return Publishers.NetworkResponseSubscription(
                request: networkRequest,
                networkModule: networkModule,
                subscriber: subscriber
            )
        }
        return nil
    }
}
