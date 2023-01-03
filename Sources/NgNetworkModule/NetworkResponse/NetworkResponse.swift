//
//  NetworkResponse.swift
//  Netguru iOS Network Module
//

import Foundation

/// A structure containing data received form server, along with original network response object.
public struct NetworkResponse {

    /// A raw response data.
    public let data: Data?

    /// An original network response object.
    public let networkResponse: HTTPURLResponse
}

public extension NetworkResponse {

    /// A convenience method decoding a network response data into a provided response type.
    ///
    /// - Parameter responseType: a response type.
    /// - Returns: a resulting response structure.
    func decoded<T: Decodable>(into responseType: T.Type) -> Result<T, NetworkError> {
        guard let data = data else {
            return .failure(NetworkError.noResponseData)
        }

        do {
            return .success(try data.decoded(into: responseType))
        } catch {
            return .failure(.responseParsingFailed)
        }
    }
}
