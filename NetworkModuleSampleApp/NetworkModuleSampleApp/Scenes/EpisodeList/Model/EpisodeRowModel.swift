//
//  EpisodeRowModel.swift
//  NetworkModuleSampleApp
//
//  Created by Kemal Ekren on 26/01/2023.
//

import Foundation

struct EpisodeRowModel: Identifiable, Equatable {
    let id: String?
    let name: String?
    let airDate: String?
    let director: String?
    let writer: String?
    let imageURL: String?
    
    init(model: EpisodeModel) {
        self.id = model.id
        self.name = model.name
        self.airDate = model.airDate
        self.director = model.director
        self.writer = model.writer
        self.imageURL = model.imageURL
    }
}
