//
//  Routes.swift
//  Netguru iOS Network Module
//

import Foundation

enum Route: Hashable {
    case home
    case episodeList(NetworkRequestType)
    case episode(requestType: NetworkRequestType, episodeId: String)
    case character
}
