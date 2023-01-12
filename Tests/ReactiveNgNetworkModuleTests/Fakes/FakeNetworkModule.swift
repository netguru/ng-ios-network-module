//
//  FakeNetworkModule.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModule
@testable import ReactiveNgNetworkModule

final class FakeNetworkModule: NetworkModule {
    var simulatedURLSessionDataTask: URLSessionDataTask?
    private var networkRequestCompletion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    private var urlRequestCompletion: ((Result<NetworkResponse, NetworkError>) -> Void)?

    func perform(request: NetworkRequest, completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) -> URLSessionTask? {
        networkRequestCompletion = completion
        return simulatedURLSessionDataTask
    }

    func perform(urlRequest: URLRequest, completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) -> URLSessionTask {
        urlRequestCompletion = completion
        return simulatedURLSessionDataTask ?? URLSession.shared.dataTask(with: urlRequest)
    }
}

extension FakeNetworkModule {

    func simulateUrlRequestSuccess(response: NetworkResponse) {
        urlRequestCompletion?(.success(response))
    }
}
