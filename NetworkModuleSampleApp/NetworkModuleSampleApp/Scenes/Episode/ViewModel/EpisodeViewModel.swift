//
//  EpisodeViewModel.swift
//  NetworkModuleSampleApp

import Foundation

final class EpisodeViewModel: EpisodeViewModelProtocol {
    
    var selectedNetworkingAPI: NetworkRequestType
    
    /// Episode Publishers
    @Published var viewState: EpisodeViewStates = .noData
    var episodeId: String
    var viewStatePublished: Published<EpisodeViewStates> { _viewState }
    var viewStatePublisher: Published<EpisodeViewStates>.Publisher { $viewState}
    
    /// Character Publishers
    @Published var characters: [CharacterModel] = []
    var charactersPublished: Published<[CharacterModel]> { _characters }
    var charactersPublisher: Published<[CharacterModel]>.Publisher { $characters}
    
    init(requestType: NetworkRequestType,
         episodeId: String) {
        self.selectedNetworkingAPI = requestType
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
    private func fetchCharacters(with id: String) {
        // TODO: Character Fetch
    }
    
    private func classicNetworkRequest() {
        // TODO: Make Classic Network request
        
    }
    
    private func combineNetworkRequest() {
        // TODO: Make Combine Network request
        
    }
    
    private func asynAwaitNetworkRequest() {
        // TODO: Make Async/Await Network request
    }
}

