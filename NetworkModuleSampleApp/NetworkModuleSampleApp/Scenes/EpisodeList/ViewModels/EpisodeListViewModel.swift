//
//  EpisodeListViewModel.swift
//  Netguru iOS Network Module
//

import Foundation
import Combine
import NgNetworkModuleCore
import ReactiveNgNetworkModule
import ConcurrentNgNetworkModule

final class EpisodeListViewModel: EpisodeListViewModelProtocol {
    @Published private(set) var viewState: EpisodeListViewState = .loading
    var viewStatePublished: Published<EpisodeListViewState> { _viewState }
    var viewStatePublisher: Published<EpisodeListViewState>.Publisher { $viewState }

    let selectedNetworkApi: NetworkModuleApiType
    let networkModule: NetworkModule

    private var task: Task<Void, Never>?
    private var urlTask: URLSessionTask?

    init(
        requestType: NetworkModuleApiType,
        networkModule: NetworkModule
    ) {
        selectedNetworkApi = requestType
        self.networkModule = networkModule
    }

    func fetchData() {
        switch selectedNetworkApi {
        case .classic:
            fetchEpisodesListUsingClassicApi()
        case .combine:
            fetchEpisodesListUsingReactiveApi()
        case .asyncAwait:
            task?.cancel()
            task = Task { [weak self] in
                await self?.fetchEpisodesListUsingAsyncAwaitApi()
            }
        }
    }
}

private extension EpisodeListViewModel {

    func fetchEpisodesListUsingClassicApi() {
        let request = GetEpisodesListRequest()
        logNetworkInfo("--- [Classic] Request started: \(request.path)")
        urlTask?.cancel()
        urlTask = networkModule.performAndDecode(
            request: request,
            responseType: [EpisodeModel].self
        ) { [weak self] result in
            switch result {
            case let .success(episodesList):
                logNetworkInfo("--- [Classic] Request completed: \(request.path)")
                self?.viewState = .loaded(episodesList)
            case let .failure(error):
                logNetworkError("--- [Classic] Request error: \(error.localizedDescription)")
                self?.viewState = .error(error)
            }
        }
    }

    func fetchEpisodesListUsingReactiveApi() {
        let request = GetEpisodesListRequest()
        logNetworkInfo("--- [Reactive] Request started: \(request.path)")
        networkModule
            .performAndDecode(request: request, responseType: [EpisodeModel].self, decoder: JSONDecoder())
            .map { episodeModels in
                logNetworkInfo("--- [Reactive] Request completed: \(request.path)")
                return EpisodeListViewState.loaded(episodeModels)
            }
            .catch {
                logNetworkError("--- [Reactive] Request error: \($0.localizedDescription)")
                return Just(EpisodeListViewState.error($0))
            }
            .assign(to: &$viewState)
    }

    func fetchEpisodesListUsingAsyncAwaitApi() async {
        let request = GetEpisodesListRequest()
        logNetworkInfo("--- [Async/Await] Request started: \(request.path)")
        do {
            let episodes = try await networkModule.performAndDecode(
                request: request,
                responseType: [EpisodeModel].self
            )
            logNetworkInfo("--- Async/AwaitRequest completed: \(request.path)")
            await updateByMainActor(viewState: .loaded(episodes))
        } catch {
            logNetworkError("--- Async/AwaitRequest error: \(error.localizedDescription)")
            await updateByMainActor(viewState: .error(error))
        }
    }

    func updateByMainActor(viewState: EpisodeListViewState) async {
        // Discussion: Alternatively, you can just annotate `viewState` with @MainActor ...
        // ... to ensure it is updated on the Main Thread.
        await MainActor.run { [weak self] in
            self?.viewState = viewState
        }
    }
}
