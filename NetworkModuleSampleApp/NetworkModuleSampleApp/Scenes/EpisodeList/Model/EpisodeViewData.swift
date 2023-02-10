//
//  EpisodeViewData.swift
//  Netguru iOS Network Module
//

import Foundation

struct EpisodeViewData: Equatable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let director: String
    let writer: String
    let imageURL: URL?
    let navigationRoute: Route
}

extension EpisodeViewData {

    init(episode: EpisodeModel, selectedNetworkApi: NetworkModuleApiType) {
        id = episode.id
        name = episode.name
        airDate = episode.airDate.orUnknown()
        director = episode.director
        writer = episode.writer
        imageURL = episode.imageURL.toSafeUrl
        navigationRoute = Route.episode(selectedNetworkApi: selectedNetworkApi, episode: episode)
    }
}
