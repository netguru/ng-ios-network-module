//
//  NetworkResponsePublisher+HandleAndDecode.swift
//  Netguru iOS Network Module
//

import Foundation
import Combine
import NgNetworkModule

extension Publisher where Output == NetworkResponse, Failure == NetworkError {

    /// A convenience operator to handle NetworkResponse and decode it if possible.
    ///
    /// - Parameters:
    ///   - responseType: an expected response type.
    ///   - decoder: a JSON decoder to use.
    /// - Returns: a handled (and possibly decoded) response publisher.
    func handleAndDecode<T: Decodable>(
        to responseType: T.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, NetworkError> {
        tryMap { response in
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
