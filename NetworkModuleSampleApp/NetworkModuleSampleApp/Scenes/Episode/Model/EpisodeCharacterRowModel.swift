//
//  EpisodeCharacterRowModel.swift
//  NetworkModuleSampleApp


import Foundation

struct EpisodeCharacterRowModel: Identifiable {
    let id: Int?
    let name: String?
    let imageURL: String?
}

extension EpisodeCharacterRowModel {
    init(model: CharacterModel) {
        self.id = model.id
        self.name = model.name
        self.imageURL = model.imageURL
    }
}
