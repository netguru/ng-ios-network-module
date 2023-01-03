//
//  Data+Codable.swift
//  Netguru iOS Network Module
//

import Foundation

extension Data {

    /// Attempts to decode a encoded object to a provided structure.
    ///
    /// - Parameter type: a type to decode an object to.
    /// - Returns: a decoded object.
    func decoded<T: Decodable>(into type: T.Type) -> T? {
        try? JSONDecoder().decode(type, from: self)
    }
}

extension Encodable {

    /// Encodes an item into data.
    ///
    /// - Returns: a data representation.
    func encoded() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
