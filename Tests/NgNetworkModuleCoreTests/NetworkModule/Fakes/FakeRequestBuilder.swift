//
//  FakeRequestBuilder.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModuleCore

final class FakeRequestBuilder: RequestBuilder {
    var simulatedUrlRequest: URLRequest?

    func build(request: NetworkRequest) -> URLRequest? {
        simulatedUrlRequest
    }
}
