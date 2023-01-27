//
//  NetworkError.swift
//  Netguru iOS Network Module
//

import Foundation

/// An enumeration representing a network error.
public enum NetworkError: Error, Equatable {
    /// Network errors associated with sending a request:
    case notFound
    case forbidden
    case unauthorized
    case invalidRequest(code: Int, message: String?)
    case serverError(code: Int, message: String?)
    case custom(code: Int, message: String?)
    case cancelled

    /// Network errors associated with parting a response:
    case requestParsingFailed
    case responseParsingFailed
    case noResponseData

    /// Other errors:
    case unknown

    /// A convenience initializer for NetworkError.
    /// Use to convert generic network errors to NetworkError type.
    ///
    /// - Parameters:
    ///   - code: an error code.
    ///   - message: an optional error message.
    public init?(code: Int, message: String?) {
        switch code {
        case 200...399:
            return nil
        case 404:
            self = .notFound
        case 403:
            self = .forbidden
        case 401:
            self = .unauthorized
        case 400...499:
            self = .invalidRequest(code: code, message: message)
        case 500...599:
            self = .serverError(code: code, message: message)
        case -999:
            self = .cancelled
        default:
            self = .custom(code: code, message: message)
        }
    }

    /// A convenience initializer for NetworkError based on provided HTTPURLResponse.
    ///
    /// - Parameter urlResponse: a response.
    public init?(urlResponse: HTTPURLResponse) {
        let statusCode = urlResponse.statusCode
        if let error = statusCode.toNetworkError(message: HTTPURLResponse.localizedString(forStatusCode: statusCode)) {
            self = error
        } else {
            return nil
        }
    }

    /// A convenience initializer for NetworkError based on provided NSError.
    ///
    /// - Parameter error: an error.
    public init(error: NSError) {
        self = NetworkError(code: error.code, message: error.localizedDescription) ?? .unknown
    }
}
