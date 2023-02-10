//
//  EpisodeViewModel.swift
//  Netguru iOS Network Module
//

import Foundation
import NgNetworkModuleCore

final class EpisodeViewModel: EpisodeViewModelProtocol {

    let selectedNetworkingAPI: NetworkModuleApiType
    let episode: EpisodeModel
    let networkModule: NetworkModule

    @Published var viewState: EpisodeViewStates
    var viewStatePublished: Published<EpisodeViewStates> { _viewState }
    var viewStatePublisher: Published<EpisodeViewStates>.Publisher { $viewState }

    private var characters: [CharacterModel] = []

    init(
        selectedNetworkingAPI: NetworkModuleApiType,
        episode: EpisodeModel,
        networkModule: NetworkModule
    ) {
        self.selectedNetworkingAPI = selectedNetworkingAPI
        self.episode = episode
        self.networkModule = networkModule
        viewState = .loading(episode)
    }

    func fetchData() {
        switch selectedNetworkingAPI {
        case .classic:
            classicNetworkRequest()
        case .combine:
            combineNetworkRequest()
        case .asyncAwait:
            asyncAwaitNetworkRequest()
        }
    }
}

private extension EpisodeViewModel {

    func classicNetworkRequest() {
        characters = []
        for characterLink in episode.characters {
            fetchCharacters(with: characterLink)
        }
    }

    func combineNetworkRequest() {
        // TODO: Make Combine Network request
    }

    func asyncAwaitNetworkRequest() {
        // TODO: Make Async/Await Network request
    }

    func fetchCharacters(with link: String) {
        guard let url = URL(string: link) else {
            viewState = .error(episode, NetworkError.requestParsingFailed)
            return
        }

        let urlRequest = URLRequest(url: url)
        networkModule.performAndDecode(
            urlRequest: urlRequest,
            responseType: CharacterModel.self
        ) { [weak self] result in
            guard let self else { return }

            switch result {
            case let .success(character):
                self.characters.append(character)
                self.viewState = .loaded(self.episode, self.characters)
            case let .failure(error):
                self.viewState = .error(self.episode, error)
            }
        }
    }
}
