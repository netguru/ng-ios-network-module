//
//  Data+Codable.swift
//  Netguru iOS Network Module
//

import Foundation

extension Data {

    /// Attempts to decode a encoded object to a provided type.
    ///
    /// - Parameter type: a type to decode an object into.
    /// - Parameter decoder: a JSON decoder.
    /// - Returns: a decoded object.
    func decoded<T: Decodable>(into type: T.Type, decoder: JSONDecoder = JSONDecoder()) -> T? {
        try? decoder.decode(type, from: self)
    }

    /// Attempts to decode an encoded object to a provided type.
    ///
    /// - Parameter type: a type to decode an object to.
    /// - Parameter decoder: a JSON decoder.
    /// - Returns: a decoded object.
    /// - Throws: a NetworkError thrown when the decoding fails.
    func decoded<T: Decodable>(into type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T {
        do {
            return try decoder.decode(type, from: self)
        } catch {
            throw NetworkError.responseParsingFailed
        }
    }
}

extension Encodable {

    /// Encodes an item into data.
    ///
    /// - Returns: a data representation.
    func encoded(encoder: JSONEncoder = JSONEncoder()) -> Data? {
        try? encoder.encode(self)
    }
}
