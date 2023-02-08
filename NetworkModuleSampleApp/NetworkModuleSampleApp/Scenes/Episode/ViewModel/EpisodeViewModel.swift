//
//  EpisodeViewModel.swift
//  Netguru iOS Network Module
//

import Foundation

final class EpisodeViewModel: EpisodeViewModelProtocol {

    let selectedNetworkingAPI: NetworkModuleApiType
    let episodeId: Int

    /// Episode Publishers
    @Published var viewState: EpisodeViewStates = .noData

    var viewStatePublished: Published<EpisodeViewStates> { _viewState }
    var viewStatePublisher: Published<EpisodeViewStates>.Publisher { $viewState }

    /// Character Publishers
    @Published var characters: [CharacterModel] = []
    var charactersPublished: Published<[CharacterModel]> { _characters }
    var charactersPublisher: Published<[CharacterModel]>.Publisher { $characters }

    init(
        requestType: NetworkModuleApiType,
        episodeId: Int
    ) {
        selectedNetworkingAPI = requestType
        self.episodeId = episodeId
    }

    func fetchData(with episodeId: String) {
        switch selectedNetworkingAPI {
        case .classic:
            classicNetworkRequest()
        case .combine:
            combineNetworkRequest()
        case .asyncAwait:
            asynAwaitNetworkRequest()
        }
    }
}

private extension EpisodeViewModel {
    func fetchCharacters(with id: String) {
        // TODO: Character Fetch
    }

    func classicNetworkRequest() {
        // TODO: Make Classic Network request
    }

    func combineNetworkRequest() {
        // TODO: Make Combine Network request
    }

    func asynAwaitNetworkRequest() {
        // TODO: Make Async/Await Network request
    }
}
