//
//  EpisodeViewModel.swift
//  NetworkModuleSampleApp

import Foundation

final class EpisodeViewModel: EpisodeViewModelProtocol {
    
    var requestType: NetworkRequestType
    
    /// Episode Publishers
    @Published var episode: EpisodeModel = EpisodeModel()
    var episodeId: String
    var episodePublished: Published<EpisodeModel> { _episode }
    var episodePublisher: Published<EpisodeModel>.Publisher { $episode}
    
    /// Character Publishers
    @Published var characters: [CharacterModel] = []
    var charactersPublished: Published<[CharacterModel]> { _characters }
    var charactersPublisher: Published<[CharacterModel]>.Publisher { $characters}
    
    init(requestType: NetworkRequestType,
         episodeId: String) {
        self.requestType = requestType
        self.episodeId = episodeId
    }
    
    func fetchData(with episodeId: String) {
        switch requestType {
        case .classic:
            classicNetworkRequest()
        case .combine:
            combineNetworkRequest()
        case .asyncAwait:
            asynAwaitNetworkRequest()
        }
    }
    
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

