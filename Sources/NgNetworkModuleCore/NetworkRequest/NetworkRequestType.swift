//
//  NetworkRequestType.swift
//  Netguru iOS Network Module
//

import Foundation

// An abstraction describing a network request type: POST, GET, etc.
public enum NetworkRequestType: Equatable {
    /// Typical network request types: GET, POST, DELETE...
    case get
    case post
    case delete
    case put
    case patch

    /// A custom network request type. Provide the type value as an associated value.
    case custom(String)
}

extension NetworkRequestType {

    /// Provides a value of a request type.
    var value: String {
        switch self {
        case let .custom(value):
            return value
        default:
            return "\(self)"
        }
    }
}
