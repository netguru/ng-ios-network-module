//
//  FakeNetworkModule.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModule
@testable import ConcurrentNgNetworkModule

final class FakeNetworkModule: NetworkModule {
    var simulatedNetworkResponse: NetworkResponse?
    var simulatedNetworkError: NetworkError?

    func perform(request: NetworkRequest, completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) -> URLSessionTask? {
        call(completion: completion)
        return nil
    }

    func perform(urlRequest: URLRequest, completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) -> URLSessionTask {
        call(completion: completion)
        return URLSession.shared.dataTask(with: urlRequest)
    }
}

private extension FakeNetworkModule {

    func call(completion: ((Result<NetworkResponse, NetworkError>) -> Void)?) {
        if let response = simulatedNetworkResponse {
            completion?(.success(response))
        } else if let error = simulatedNetworkError {
            completion?(.failure(error))
        }
    }
}
