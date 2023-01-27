//
//  FakeNetworkRequest.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModuleCore

struct EmptyNetworkRequest: NetworkRequest {
    let path = "/delete"
    let method = NetworkRequestType.delete
}

struct FakePostNetworkRequest: NetworkRequest {
    let method = NetworkRequestType.post
    let path: String
    let body: Encodable?
    let bodyData: Data?
    let additionalHeaderFields: [String: String]
    let cachePolicy: NSURLRequest.CachePolicy

    init(
        path: String = "/welcome",
        body: Encodable? = FakeRequestBody(foo: "bar"),
        bodyData: Data? = nil,
        additionalHeaderFields: [String: String] = [:],
        cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringCacheData
    ) {
        self.body = body
        self.bodyData = bodyData
        self.path = path
        self.additionalHeaderFields = additionalHeaderFields
        self.cachePolicy = cachePolicy
    }
}

struct FakeGetNetworkRequest: NetworkRequest {
    let method = NetworkRequestType.get
    let path: String
    let parameters: [String: String]?
    let additionalHeaderFields: [String: String]
    let cachePolicy: NSURLRequest.CachePolicy
    let requiresAuthenticationToken: Bool

    init(
        path: String = "/welcome",
        parameters: [String: String]? = nil,
        additionalHeaderFields: [String: String] = [:],
        cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringCacheData,
        requiresAuthenticationToken: Bool = false
    ) {
        self.path = path
        self.parameters = parameters
        self.additionalHeaderFields = additionalHeaderFields
        self.cachePolicy = cachePolicy
        self.requiresAuthenticationToken = requiresAuthenticationToken
    }
}

struct FakeRequestBody: Codable, Equatable {
    let foo: String
}
