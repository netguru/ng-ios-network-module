//
//  EpisodeListViewModel.swift
//  NetworkModuleSampleApp


import Foundation

final class EpisodeListViewModel: EpisodeListViewModelProtocol {
    @Published var viewState: EpisodeListViewStates = .noData
    
    var requestType: NetworkRequestType
    
    var viewStatePublished: Published<EpisodeListViewStates> { _viewState }
    
    var viewStatePublisher: Published<EpisodeListViewStates>.Publisher { $viewState }
    
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
}

private extension EpisodeListViewModel {
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
