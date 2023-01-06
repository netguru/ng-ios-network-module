//
//  RequestBuilder.swift
//  Netguru iOS Network Module
//

import Foundation

/// An abstraction describing an URL request builder.
public protocol RequestBuilder: AnyObject {

    /// Builds an URL request from a provided request abstraction.
    ///
    /// - Parameter request: a requst abstraction.
    /// - Returns: an URL request.
    func build(request: NetworkRequest) -> URLRequest?
}

/// A default implementation of a RequestBuilder.
public final class DefaultRequestBuilder: RequestBuilder {
    private let baseURL: URL

    // MARK: - Initializers

    /// A default initializer for DefaultRequestBuilder.
    ///
    /// - Parameter baseURL: a base url.
    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    /// - SeeAlso: RequestBuilder.build(request:)
    public func build(request: NetworkRequest) -> URLRequest? {
        guard let url = composeURL(request: request) else {
            return nil
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.cachePolicy = request.cachePolicy
        urlRequest.httpMethod = request.method.value
        urlRequest.httpBody = request.encodedBody
        append(additionalHeaderFields: request.additionalHeaderFields, toRequest: &urlRequest)

        return urlRequest
    }
}

// MARK: - Implementation details

private extension DefaultRequestBuilder {

    func composeURL(request: NetworkRequest) -> URL? {
        let requestPath = composeRequestPath(request: request)
        var components = URLComponents(string: requestPath)
        if let parameters = request.parameters {
            components?.queryItems = composeQueryItems(fromParameters: parameters)
        }
        return components?.url
    }

    func composeRequestPath(request: NetworkRequest) -> String {
        if request.hasAbsolutePath {
            return request.path
        }
        return "\(baseURL.absoluteString)\(request.path)"
    }

    func composeQueryItems(fromParameters parameters: [String: Any]) -> [URLQueryItem] {
        parameters.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
    }

    func append(additionalHeaderFields fields: [String: String], toRequest urlRequest: inout URLRequest) {
        for (key, value) in fields {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}
