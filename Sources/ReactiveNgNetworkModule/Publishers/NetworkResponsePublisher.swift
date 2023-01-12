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

        private let urlRequest: URLRequest
        private let networkModule: NetworkModule

        /// A default NetworkResponsePublisher initializer.
        /// To be used to execute a generic URLRequest.
        ///
        /// - Parameters:
        ///   - urlRequest: a URL request to execute.
        ///   - networkModule: a network module executing the request.
        init(urlRequest: URLRequest, networkModule: NetworkModule) {
            self.urlRequest = urlRequest
            self.networkModule = networkModule
        }

        /// - SeeAlso: Publisher.receive(subscriber:)
        public func receive<S: Subscriber>(subscriber: S)
            where NetworkResponsePublisher.Failure == S.Failure, NetworkResponsePublisher.Output == S.Input {
            let subscription = NetworkResponseSubscription(urlRequest: urlRequest, networkModule: networkModule, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
}
