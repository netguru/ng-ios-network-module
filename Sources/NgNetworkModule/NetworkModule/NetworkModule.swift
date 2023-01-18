//
//  NetworkModule.swift
//  Netguru iOS Network Module
//

import Foundation
import Network

/// An abstraction describing networking module for the app.
public protocol NetworkModule: AnyObject {

    /// Performs a network request returning an answer in a callback.
    ///
    /// - Parameters:
    ///   - request: a request to execute.
    ///   - completion: a completion callback.
    /// - Returns: a network session task (if created).
    @discardableResult func perform(
        request: NetworkRequest,
        completion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    ) -> URLSessionTask?

    /// Performs an URL request returning an answer in a callback.
    ///
    /// - Parameters:
    ///   - urlRequest: a request to execute.
    ///   - completion: a completion callback.
    /// - Returns: a network session task.
    @discardableResult func perform(
        urlRequest: URLRequest,
        completion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    ) -> URLSessionTask
}

public extension NetworkModule {

    /// A convenience method to perform request, decode a response, and return an answer in a callback.
    ///
    /// - Parameters:
    ///   - request: a request to execute.
    ///   - responseType: a response type.
    ///   - decoder: a JSON decoder.
    ///   - completion: a completion callback.
    /// - Returns: a network session task (if created).
    @discardableResult func performAndDecode<T: Decodable>(
        request: NetworkRequest,
        responseType: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        completion: ((Result<T, NetworkError>) -> Void)?
    ) -> URLSessionTask? {
        perform(request: request) { result in
            switch result {
            case let .success(response):
                completion?(response.decoded(into: responseType, decoder: decoder))
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }

    /// A convenience method to perform URL request, decode a response, and return an answer in a callback.
    ///
    /// - Parameters:
    ///   - urlRequest: a request to execute.
    ///   - responseType: a response type.
    ///   - decoder: a JSON decoder.
    ///   - completion: a completion callback.
    /// - Returns: a network session task.
    @discardableResult func performAndDecode<T: Decodable>(
        urlRequest: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        completion: ((Result<T, NetworkError>) -> Void)?
    ) -> URLSessionTask {
        perform(urlRequest: urlRequest) { result in
            switch result {
            case let .success(response):
                completion?(response.decoded(into: responseType, decoder: decoder))
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
}
