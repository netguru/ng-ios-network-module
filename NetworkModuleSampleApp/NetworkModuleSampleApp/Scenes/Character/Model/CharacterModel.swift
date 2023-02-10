//
//  CharacterModel.swift
//  Netguru iOS Network Module
//

import Foundation

struct CharacterModel: Identifiable, Equatable, Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String?
    let gender: String?
    let hair: String?
    let alias: [String]
    let origin: String
    let abilities: [String]
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case hair
        case alias
        case origin
        case abilities
        case imageURL = "img_url"
    }
}
