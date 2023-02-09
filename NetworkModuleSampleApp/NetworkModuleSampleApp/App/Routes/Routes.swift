//
//  Routes.swift
//  Netguru iOS Network Module
//

import Foundation

enum Route: Hashable {
    case home
    case episodeList(NetworkModuleApiType)
    case episode(requestType: NetworkModuleApiType, episodeId: Int)
    case character
}
