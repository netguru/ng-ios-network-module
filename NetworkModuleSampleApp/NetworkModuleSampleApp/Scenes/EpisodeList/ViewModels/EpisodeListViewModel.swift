//
//  EpisodeListViewModel.swift
//  NetworkModuleSampleApp


import Foundation

final class EpisodeListViewModel: EpisodeListViewModelProtocol {
    @Published var episodeList: EpisodeListModel = EpisodeListModel(episodes: [])
    
    var requestType: NetworkRequestType
    
    var episodeListPublished: Published<EpisodeListModel> { _episodeList }
    
    var episodeListPublisher: Published<EpisodeListModel>.Publisher { $episodeList }
    
    init(requestType: NetworkRequestType) {
        self.requestType = requestType
    }
    
    func fetchData() {
        switch requestType {
        case .classic:
            classicNetworkRequest()
        case .combine:
            combineNetworkRequest()
        case .asyncAwait:
            asynAwaitNetworkRequest()
        }
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
