//
//  EpisodeCharacterRowModel.swift
//  Netguru iOS Network Module
//

import Foundation

struct EpisodeCharacterRowModel: Identifiable {
    let id: Int?
    let name: String?
    let imageURL: String?
}

extension EpisodeCharacterRowModel {
    init(model: CharacterModel) {
        id = model.id
        name = model.name
        imageURL = model.imageURL
    }
}
