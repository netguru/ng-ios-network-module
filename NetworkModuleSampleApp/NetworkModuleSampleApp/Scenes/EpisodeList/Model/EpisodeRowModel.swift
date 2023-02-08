//
//  EpisodeRowModel.swift
//  Netguru iOS Network Module
//

import Foundation

struct EpisodeRowModel: Identifiable, Equatable {
    let id: Int
    let name: String
    let airDate: String?
    let director: String
    let writer: String
    let imageURL: String
}

extension EpisodeRowModel {

    var secureImageURL: String {
        imageURL.replacingOccurrences(of: "http://", with: "https://")
    }

    init(model: EpisodeModel) {
        id = model.id
        name = model.name
        airDate = model.airDate
        director = model.director
        writer = model.writer
        imageURL = model.imageURL
    }
}
