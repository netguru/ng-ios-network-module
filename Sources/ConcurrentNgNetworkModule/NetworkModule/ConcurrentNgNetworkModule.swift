//
//  ConcurrentNgNetworkModule.swift
//  Netguru iOS Network Module
//

import Foundation
import Combine
import NgNetworkModuleCore

public extension NetworkModule {

    /// A convenience method allowing to execute an URL request and receive response using async/await API.
    ///
    /// - Parameter urlRequest: an URL request to execute.
    /// - Returns: a network response.
    /// - Throws: a network error.
    func perform(urlRequest: URLRequest) async throws -> NetworkResponse {
        try await withCheckedThrowingContinuation { continuation in
            perform(urlRequest: urlRequest) { [weak self] result in
                self?.handle(networkCallResult: result, continuation: continuation)
            }
        }
    }

    /// A convenience method allowing to execute a network request and receive response using async/await API.
    ///
    /// - Parameter request: an network request to execute.
    /// - Returns: a network response.
    /// - Throws: a network error.
    func perform(request: NetworkRequest) async throws -> NetworkResponse {
        try await withCheckedThrowingContinuation { continuation in
            perform(request: request) { [weak self] result in
                self?.handle(networkCallResult: result, continuation: continuation)
            }
        }
    }

    /// A convenience method allowing to execute an URL request, parse a response and return it using async/await API.
    ///
    /// - Parameters:
    ///   - urlRequest: an URL request to execute.
    ///   - responseType: an expected response type.
    ///   - decoder: a JSON decoder.
    /// - Returns: a publisher to subscribe to.
    func performAndDecode<T: Decodable>(
        urlRequest: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            performAndDecode(
                urlRequest: urlRequest,
                responseType: responseType,
                decoder: decoder
            ) { [weak self] result in
                self?.handle(networkCallResult: result, continuation: continuation)
            }
        }
    }

    /// A convenience method allowing to execute a network request, parse a response and return it using async/await API.
    ///
    /// - Parameters:
    ///   - request: a network request to execute.
    ///   - responseType: an expected response type.
    ///   - decoder: a JSON decoder.
    /// - Returns: a publisher to subscribe to.
    func performAndDecode<T: Decodable>(
        request: NetworkRequest,
        responseType: T.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            performAndDecode(
                request: request,
                responseType: responseType,
                decoder: decoder
            ) { [weak self] result in
                self?.handle(networkCallResult: result, continuation: continuation)
            }
        }
    }
}

extension NetworkModule {

    func handle<T>(
        networkCallResult result: Result<T, NetworkError>,
        continuation: CheckedContinuation<T, Error>
    ) {
        switch result {
        case let .success(decodedResponse):
            continuation.resume(returning: decodedResponse)
        case let .failure(error):
            continuation.resume(throwing: error)
        }
    }
}
