//
//  NetworkResponseSubscription.swift
//  Netguru iOS Network Module
//

import Foundation
import Combine
import NgNetworkModuleCore

public extension Publishers {

    /// A class representing a subscription to NetworkModule reactive API.
    final class NetworkResponseSubscription<S: Subscriber>: Subscription
        where S.Input == NetworkResponse, S.Failure == NetworkError {

        private let networkModule: NetworkModule
        private var subscriber: S?
        private var request: NetworkRequest?
        private var urlRequest: URLRequest?

        /// A default NetworkResponseSubscription initializer.
        /// To be used when executing a generic URLRequest.
        ///
        /// - Parameters:
        ///   - urlRequest: a URL request to execute.
        ///   - networkModule: a network module executing the request.
        ///   - subscriber: a subscriber to be notified.
        public init(urlRequest: URLRequest, networkModule: NetworkModule, subscriber: S) {
            self.subscriber = subscriber
            self.networkModule = networkModule
            self.urlRequest = urlRequest
            request = nil
        }

        /// A supplementary NetworkResponseSubscription initializer.
        /// To be used when executing a network request.
        ///
        /// - Parameters:
        ///   - request: a network request to execute.
        ///   - networkModule: a network module executing the request.
        ///   - subscriber: a subscriber to be notified.
        public init(request: NetworkRequest, networkModule: NetworkModule, subscriber: S) {
            self.subscriber = subscriber
            self.networkModule = networkModule
            self.request = request
            urlRequest = nil
        }

        /// - SeeAlso: Subscription.request(demand:)
        public func request(_ demand: Subscribers.Demand) {
            if let request = request {
                perform(request: request)
            } else if let urlRequest = urlRequest {
                perform(urlRequest: urlRequest)
            }
        }

        /// - SeeAlso: Subscription.cancel()
        public func cancel() {
            subscriber = nil
        }
    }
}

private extension Publishers.NetworkResponseSubscription {

    func perform(request: NetworkRequest) {
        networkModule.perform(request: request) { [subscriber] result in
            switch result {
            case let .success(response):
                _ = subscriber?.receive(response)
                subscriber?.receive(completion: Subscribers.Completion.finished)
            case let .failure(error):
                subscriber?.receive(completion: Subscribers.Completion.failure(error))
            }
        }
    }

    func perform(urlRequest: URLRequest) {
        networkModule.perform(urlRequest: urlRequest) { [subscriber] result in
            switch result {
            case let .success(response):
                _ = subscriber?.receive(response)
                subscriber?.receive(completion: Subscribers.Completion.finished)
            case let .failure(error):
                subscriber?.receive(completion: Subscribers.Completion.failure(error))
            }
        }
    }
}
