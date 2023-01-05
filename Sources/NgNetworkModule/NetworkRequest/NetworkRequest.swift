//
//  NetworkRequest.swift
//  Netguru iOS Network Module
//

import Foundation

// MARK: - NetworkRequest

/// An abstraction describing networking module request.
public protocol NetworkRequest {

    /// A request path.
    var path: String { get }

    /// A request method.
    var method: NetworkRequestType { get }

    /// A request caching policy.
    var cachePolicy: NSURLRequest.CachePolicy { get }

    /// Additional request header fields.
    var additionalHeaderFields: [String: String] { get }

    /// A request parameters.
    var parameters: [String: String]? { get }

    /// A request body. Taken into consideration only when `NetworkRequest.bodyData` is undefined.
    var body: Encodable? { get }

    /// A request body data. To be used as an alternative to (and takes precedence over) `NetworkRequest.body`.
    var bodyData: Data? { get }

    /// A flag indicating if a request requires an access token.
    var requiresAuthenticationToken: Bool { get }
}

// MARK: - Default NetworkRequest implementation

/// Default implementation of NetworkRequest protocol.
public extension NetworkRequest {

    /// - SeeAlso: NetworkRequest.parameters
    var parameters: [String: String]? {
        nil
    }

    /// - SeeAlso: NetworkRequest.body
    var body: Encodable? {
        nil
    }

    /// - SeeAlso: NetworkRequest.bodyData
    var bodyData: Data? {
        nil
    }

    /// - SeeAlso: NetworkRequest.cachePolicy
    var cachePolicy: NSURLRequest.CachePolicy {
        .reloadIgnoringCacheData
    }

    /// - SeeAlso: NetworkRequest.additionalHeaderFields
    /// By default, adding Content-Type and Accept header fields.
    var additionalHeaderFields: [String: String] {
        [
            NetworkRequestConstants.contentTypeFieldName: NetworkRequestConstants.contentTypeFieldValue,
            NetworkRequestConstants.acceptFieldName: NetworkRequestConstants.acceptFieldValue
        ]
    }

    /// - SeeAlso: NetworkRequest.requiresAuthenticationToken
    var requiresAuthenticationToken: Bool {
        false
    }
}

// MARK: - Internal implementation details

extension NetworkRequest {

    /// A helper property providing encoded request body.
    var encodedBody: Data? {
        bodyData ?? body?.encoded()
    }

    /// Indicates if a request has an absolute path.
    var hasAbsolutePath: Bool {
        if let url = URL(string: path), url.host != nil {
            return true
        }
        return false
    }
}

private enum NetworkRequestConstants {
    static let contentTypeFieldName = "Content-Type"
    static let contentTypeFieldValue = "application/json"
    static let acceptFieldName = "Accept"
    static let acceptFieldValue = "application/json"
}
