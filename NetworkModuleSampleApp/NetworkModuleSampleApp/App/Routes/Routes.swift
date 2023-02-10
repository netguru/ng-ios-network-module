//
//  Routes.swift
//  Netguru iOS Network Module
//

import Foundation

enum Route: Hashable {
    case home
    case episodeList(requestType: NetworkModuleApiType)
    case episode(selectedNetworkApi: NetworkModuleApiType, episode: EpisodeModel)
}
