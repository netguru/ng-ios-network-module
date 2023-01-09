//
//  NetworkErrorConvertible.swift
//  Netguru iOS Network Module
//

import Foundation

/// An abstraction allowing to convert a conforming object into a NetworkError.
public protocol NetworkErrorConvertible {

    /// Converts an object to a NetworkError (with empty error message).
    /// 
    /// - Returns: a NetworkError.
    func toNetworkError() -> NetworkError?

    /// Converts an object to a NetworkError (with a provided message).
    /// 
    /// - Parameter message: an error message to use.
    /// - Returns: a NetworkError.
    func toNetworkError(message: String?) -> NetworkError?
}

extension NetworkErrorConvertible {

    /// A default implementation of error conversion. Uses empty error message.
    /// 
    /// - Returns: a NetworkError.
    public func toNetworkError() -> NetworkError? {
        toNetworkError(message: nil)
    }
}

extension Int: NetworkErrorConvertible {

    /// - SeeAlso: NetworkErrorConvertible.toNetworkError(message:)
    public func toNetworkError(message: String?) -> NetworkError? {
        NetworkError(code: self, message: message)
    }
}

extension HTTPURLResponse: NetworkErrorConvertible {

    /// - SeeAlso: NetworkErrorConvertible.toNetworkError(message:)
    public func toNetworkError(message: String?) -> NetworkError? {
        let message = message ?? HTTPURLResponse.localizedString(forStatusCode: statusCode)
        return statusCode.toNetworkError(message: message)
    }
}
