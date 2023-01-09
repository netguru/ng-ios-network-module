//
//  FakeNetworkSession.swift
//  Netguru iOS Network Module
//

import UIKit

@testable import NgNetworkModule

final class FakeNetworkSession: NetworkSession {
    var simulatedURLSessionDataTask: URLSessionDataTask?
    private(set) var lastProcessedRequest: URLRequest?
    private var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.completionHandler = completionHandler
        return simulatedURLSessionDataTask ?? URLSession.shared.dataTask(with: request)
    }
}

extension FakeNetworkSession {

    func simulateSuccess(data: Data?, response: URLResponse?) {
        completionHandler?(data, response, nil)
    }

    func simulateFailure(response: URLResponse?, error: Error?) {
        completionHandler?(nil, response, error)
    }
}
