//
//  NetworkResponsePublisher+HandleAndDecode.swift
//  Netguru iOS Network Module
//

import Foundation
import Combine
import NgNetworkModuleCore

extension Publisher where Output == NetworkResponse, Failure == NetworkError {

    /// A convenience operator to handle NetworkResponse and decode it if possible.
    ///
    /// - Parameters:
    ///   - responseType: an expected response type.
    ///   - decoder: a top level decoder to use.
    /// - Returns: a handled (and possibly decoded) response publisher.
    func handleAndDecode<T: Decodable, Coder: TopLevelDecoder>(
        to responseType: T.Type,
        decoder: Coder = JSONDecoder()
    ) -> AnyPublisher<T, NetworkError> where Coder.Input == Data {
        tryMap { response -> Data in
            guard let data = response.data else {
                throw NetworkError.noResponseData
            }
            return data
        }
        .decode(type: responseType, decoder: decoder)
        .mapError { error in
            switch error {
            case is NetworkError:
                return error as? NetworkError ?? NetworkError.unknown
            case is DecodingError:
                return NetworkError.responseParsingFailed
            default:
                return NetworkError.unknown
            }
        }
        .eraseToAnyPublisher()
    }
}
