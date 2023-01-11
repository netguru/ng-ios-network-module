//
//  FakeRequestBuilder.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModule

final class FakeRequestBuilder: RequestBuilder {
    var simulatedUrlRequest: URLRequest?

    func build(request: NetworkRequest) -> URLRequest? {
        simulatedUrlRequest
    }
}
