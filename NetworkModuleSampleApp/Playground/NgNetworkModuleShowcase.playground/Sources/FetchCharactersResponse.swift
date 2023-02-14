//
//  FetchCharactersResponse.swift
//  Netguru iOS Network Module
//

import Foundation

public struct FetchCharactersResponse: Decodable {
    public let id: Int
    public let name: String
    public let species: String?
    public let alias: [String]
    public let origin: String
    public let abilities: [String]
    public let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case species
        case alias
        case origin
        case abilities
        case imageUrl = "img_url"
    }
}
