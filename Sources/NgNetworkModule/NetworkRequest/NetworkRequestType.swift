//
//  NetworkRequestType.swift
//  Netguru iOS Network Module
//

import Foundation

// MARK: - NetworkRequestType

// An abstraction describing a network request type: POST, GET, etc.
public enum NetworkRequestType: Equatable {
    /// A GET network request type.
    case get
    
    /// A POST network request type.
    case post
    
    /// A DELETE network request type.
    case delete
    
    /// A PUT network request type.
    case put
    
    /// A PATCH network request type.
    case patch
    
    /// A custom network request type. Provide the type value as an associated value.
    case custom(String)
}

// MARK: - Internal implementation details

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
