//
//  EpisodeViewModelProtocol.swift
//  Netguru iOS Network Module
//

import SwiftUI

enum EpisodeViewStates: Equatable {
    case loading
    case noData
    case loadedEpisode(EpisodeModel, [CharacterModel])
    /// Could be created Custom error model
    case error(Error)

    static func == (lhs: EpisodeViewStates, rhs: EpisodeViewStates) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData),
             (.loading, .loading):
            return true
        case let (.error(e1), .error(e2)):
            return e1.localizedDescription == e2.localizedDescription
        case let (.loadedEpisode(data1, char1), .loadedEpisode(data2, char2)):
            return data1.id == data2.id && char1 == char2
        default:
            return false
        }
    }
}

protocol EpisodeViewModelProtocol: AnyObject, ObservableObject {
    var selectedNetworkingAPI: NetworkRequestType { get }

    /// Episode Publisher Properties
    var viewState: EpisodeViewStates { get }
    var viewStatePublished: Published<EpisodeViewStates> { get }
    var viewStatePublisher: Published<EpisodeViewStates>.Publisher { get }

    /// Character Publisher Properties
    var characters: [CharacterModel] { get }
    var charactersPublished: Published<[CharacterModel]> { get }
    var charactersPublisher: Published<[CharacterModel]>.Publisher { get }

    func fetchData(with episodeId: String)
}
