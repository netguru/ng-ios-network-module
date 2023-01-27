//
//  FakeNetworkModule.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModuleCore
@testable import ReactiveNgNetworkModule

final class FakeNetworkModule: NetworkModule {
    private var networkRequestCompletion: ((Result<NetworkResponse, NetworkError>) -> Void)?
    private var urlRequestCompletion: ((Result<NetworkResponse, NetworkError>) -> Void)?

    func perform(request: NetworkRequest, completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) -> URLSessionTask? {
        networkRequestCompletion = completion
        return nil
    }

    func perform(urlRequest: URLRequest, completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) -> URLSessionTask {
        urlRequestCompletion = completion
        return URLSession.shared.dataTask(with: urlRequest)
    }
}

extension FakeNetworkModule {

    func simulateUrlRequestSuccess(response: NetworkResponse) {
        urlRequestCompletion?(.success(response))
    }

    func simulateUrlRequestFailure(error: NetworkError) {
        urlRequestCompletion?(.failure(error))
    }

    func simulateNetworkRequestSuccess(response: NetworkResponse) {
        networkRequestCompletion?(.success(response))
    }

    func simulateNetworkRequestFailure(error: NetworkError) {
        networkRequestCompletion?(.failure(error))
    }
}
