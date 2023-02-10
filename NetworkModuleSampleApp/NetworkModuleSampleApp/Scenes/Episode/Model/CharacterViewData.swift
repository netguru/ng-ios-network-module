//
//  CharacterViewData.swift
//  Netguru iOS Network Module
//

import Foundation

struct CharacterViewData: Identifiable {
    let id: Int
    let name: String
    let imageURL: URL?

    // TODO: add other properties from CharacterModel
}

extension CharacterViewData {

    init(model: CharacterModel) {
        id = model.id
        name = model.name
        imageURL = model.imageURL.toSafeUrl
    }
}
