//
//  EpisodeModel.swift
//  NetworkModuleSampleApp

import Foundation

struct EpisodeModel: Identifiable {
    var id: String?
    var name: String?
    var airDate: String?
    var director: String?
    var writer: String?
    var characters: [String]
    var imageURL: String?
}
