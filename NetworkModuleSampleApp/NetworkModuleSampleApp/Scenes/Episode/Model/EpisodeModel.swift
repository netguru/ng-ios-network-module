//
//  EpisodeModel.swift
//  Netguru iOS Network Module
//

import Foundation

struct EpisodeModel: Identifiable, Equatable {
    let id: String?
    let name: String?
    let airDate: String?
    let director: String?
    let writer: String?
    let characters: [String]?
    let imageURL: String?
}
