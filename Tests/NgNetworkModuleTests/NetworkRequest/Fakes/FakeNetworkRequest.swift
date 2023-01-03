//
//  FakeNetworkRequest.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModule

struct FakePostNetworkRequest: NetworkRequest {
    let path: String = "https://netguru.com/welcome"
    let method = NetworkRequestType.post
    let body: Encodable? = FakeRequestBody(foo: "bar")
}

struct FakePostNetworkRequestWithDataBody: NetworkRequest {
    static let FIXTURE_BODY_CONTENT = "FIXTURE_BODY_CONTENT"
    let path: String = "https://netguru.com/welcome"
    let method = NetworkRequestType.post
    let body: Encodable? = FakeRequestBody(foo: "bar")
    let bodyData = FIXTURE_BODY_CONTENT.encoded()
}

struct FakeRequestBody: Codable, Equatable {
    let foo: String
}
