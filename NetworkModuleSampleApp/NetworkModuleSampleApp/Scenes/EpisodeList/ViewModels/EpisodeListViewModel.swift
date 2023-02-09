//
//  EpisodeListViewModel.swift
//  Netguru iOS Network Module
//

import Foundation
import NgNetworkModuleCore

final class EpisodeListViewModel: EpisodeListViewModelProtocol {
    @Published private(set) var viewState: EpisodeListViewState = .loading
    var viewStatePublished: Published<EpisodeListViewState> { _viewState }
    var viewStatePublisher: Published<EpisodeListViewState>.Publisher { $viewState }

    let requestType: NetworkModuleApiType
    let networkModule: NetworkModule

    init(
        requestType: NetworkModuleApiType,
        networkModule: NetworkModule
    ) {
        self.requestType = requestType
        self.networkModule = networkModule
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
        let request = GetEpisodesListRequest()
        networkModule.performAndDecode(request: request, responseType: [EpisodeModel].self) { [weak self] result in
            switch result {
            case let .success(episodesList):
                self?.viewState = .loaded(episodesList)
            case let .failure(error):
                self?.viewState = .error(error)
            }
        }
    }

    func combineNetworkRequest() {
        // TODO: Make Combine Network request
    }

    func asynAwaitNetworkRequest() {
        // TODO: Make Async/Await Network request
    }
}
