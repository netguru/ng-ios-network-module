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

        private var networkModule: NetworkModule?
        private var subscriber: S?
        private var request: NetworkRequest?
        private var urlRequest: URLRequest?
        private var currentTask: URLSessionTask?

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
            if let subscriber = subscriber, demand > 0 {
                if let request = request {
                    perform(request: request, subscriber: subscriber)
                } else if let urlRequest = urlRequest {
                    perform(urlRequest: urlRequest, subscriber: subscriber)
                }
            }
        }

        /// - SeeAlso: Subscription.cancel()
        public func cancel() {
            currentTask?.cancel()
            subscriber = nil
            cleanUp()
        }
    }
}

private extension Publishers.NetworkResponseSubscription {

    func perform(request: NetworkRequest, subscriber: S) {
        currentTask = networkModule?.perform(request: request) { [weak self] result in
            switch result {
            case let .success(response):
                // Ignoring the received `demand` as the can be only one active connection per subscription.
                _ = subscriber.receive(response)
                subscriber.receive(completion: Subscribers.Completion.finished)
            case let .failure(error):
                subscriber.receive(completion: Subscribers.Completion.failure(error))
            }
            self?.cleanUp()
        }
    }

    func perform(urlRequest: URLRequest, subscriber: S) {
        currentTask = networkModule?.perform(urlRequest: urlRequest) { [weak self] result in
            switch result {
            case let .success(response):
                // Ignoring the received `demand` as the can be only one active connection per subscription.
                _ = subscriber.receive(response)
                subscriber.receive(completion: Subscribers.Completion.finished)
            case let .failure(error):
                subscriber.receive(completion: Subscribers.Completion.failure(error))
            }
            self?.cleanUp()
        }
    }

    func cleanUp() {
        networkModule = nil
        urlRequest = nil
        request = nil
    }
}
