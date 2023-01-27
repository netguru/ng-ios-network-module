//
//  NetworkSession.swift
//  Netguru iOS Network Module
//

import Foundation

/// Convenience wrapper for Foundation URL Session.
/// - SeeAlso: Foundation.URLSession
public protocol NetworkSession: AnyObject {

    /// Creates a URL session data task.
    ///
    /// - Parameters:
    ///   - request: an URL request.
    ///   - completionHandler: a request completion callback.
    /// - Returns: an URL data task.
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}
