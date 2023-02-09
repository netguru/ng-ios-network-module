//
//  EpisodeModel.swift
//  Netguru iOS Network Module
//

import Foundation

struct EpisodeModel: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let airDate: String?
    let director: String
    let writer: String
    let characters: [String]
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case director
        case writer
        case characters
        case imageURL = "img_url"
    }
}
