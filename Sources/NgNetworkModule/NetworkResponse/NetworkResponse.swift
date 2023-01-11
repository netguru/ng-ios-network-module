//
//  NetworkResponse.swift
//  Netguru iOS Network Module
//

import Foundation

/// A structure containing data received form server, along with original network response object.
public struct NetworkResponse: Equatable {

    /// A raw response data.
    public let data: Data?

    /// An original network response object.
    public let networkResponse: HTTPURLResponse
}

public extension NetworkResponse {

    /// A convenience method decoding a network response data into a provided response type.
    ///
    /// - Parameter responseType: a response type.
    /// - Parameter decoder: a JSON decoder.
    /// - Returns: a resulting response structure.
    func decoded<T: Decodable>(
        into responseType: T.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) -> Result<T, NetworkError> {
        guard let data = data else {
            return .failure(NetworkError.noResponseData)
        }

        do {
            return .success(try data.decoded(into: responseType, decoder: decoder))
        } catch {
            return .failure(.responseParsingFailed)
        }
    }
}
