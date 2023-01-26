//
//  EpisodeCharacterRowModel.swift
//  NetworkModuleSampleApp


import Foundation

struct EpisodeCharacterRowModel: Identifiable {
    let id: Int?
    let name: String?
    let imageURL: String?
    
    /// After Character Mock data created this init will be deleted
    init(id: Int?, name: String?, imageURL: String?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
    
    init(model: CharacterModel) {
        self.id = model.id
        self.name = model.name
        self.imageURL = model.imageURL
    }
}
