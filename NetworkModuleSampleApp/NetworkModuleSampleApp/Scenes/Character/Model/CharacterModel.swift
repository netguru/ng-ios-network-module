//
//  CharacterModel.swift
//  Netguru iOS Network Module
//

import Foundation

struct CharacterModel: Identifiable, Equatable {
    let id: Int?
    let name, status, species, gender: String?
    let hair: String?
    let alias: [String]?
    let origin: String?
    let abilities: [String]?
    let imageURL: String?
}
