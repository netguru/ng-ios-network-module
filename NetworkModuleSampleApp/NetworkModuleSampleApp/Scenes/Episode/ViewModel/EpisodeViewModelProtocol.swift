//
//  EpisodeViewModelProtocol.swift
//  Netguru iOS Network Module
//

import SwiftUI

enum EpisodeViewState: Equatable {
    case loading(EpisodeModel)
    case loaded(EpisodeModel, [CharacterModel])
    case error(EpisodeModel, Error)

    static func == (lhs: EpisodeViewState, rhs: EpisodeViewState) -> Bool {
        switch (lhs, rhs) {
        case let (.error(data1, e1), .error(data2, e2)):
            return data1.id == data2.id && e1.localizedDescription == e2.localizedDescription
        case let (.loading(data1), .loading(data2)):
            return data1.id == data2.id
        case let (.loaded(data1, char1), .loaded(data2, char2)):
            return data1.id == data2.id && char1 == char2
        default:
            return false
        }
    }
}

protocol EpisodeViewModelProtocol: AnyObject, ObservableObject {
    var selectedNetworkingAPI: NetworkModuleApiType { get }

    /// Episode Publisher Properties
    var viewState: EpisodeViewState { get }
    var viewStatePublished: Published<EpisodeViewState> { get }
    var viewStatePublisher: Published<EpisodeViewState>.Publisher { get }

    func fetchData()
}
