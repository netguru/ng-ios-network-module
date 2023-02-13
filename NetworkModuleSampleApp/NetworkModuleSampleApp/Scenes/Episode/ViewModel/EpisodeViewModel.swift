//
//  EpisodeViewModel.swift
//  Netguru iOS Network Module
//

import Foundation
import NgNetworkModuleCore
import ReactiveNgNetworkModule
import Combine

final class EpisodeViewModel: EpisodeViewModelProtocol {

    let selectedNetworkingAPI: NetworkModuleApiType
    let episode: EpisodeModel
    let networkModule: NetworkModule

    @Published var viewState: EpisodeViewState
    var viewStatePublished: Published<EpisodeViewState> { _viewState }
    var viewStatePublisher: Published<EpisodeViewState>.Publisher { $viewState }

    private var characters: [CharacterModel] = []
    private var cancellables: Set<AnyCancellable> = []
    private var tasks: [Task<Void, Never>] = []
    private var urlTasks: [URLSessionTask] = []

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
        cleanUp()
        for characterLink in episode.characters {
            guard let url = URL(string: characterLink) else {
                viewState = .error(episode, NetworkError.requestParsingFailed)
                return
            }

            let urlRequest = URLRequest(url: url)
            call(api: selectedNetworkingAPI, urlRequest: urlRequest)
        }
    }
}

private extension EpisodeViewModel {

    func call(api: NetworkModuleApiType, urlRequest: URLRequest) {
        switch selectedNetworkingAPI {
        case .classic:
            fetchCharacterDataUsingClassicApi(urlRequest: urlRequest)
        case .combine:
            fetchCharacterDataUsingReactiveApi(urlRequest: urlRequest)
        case .asyncAwait:
            let task = Task<Void, Never> { [weak self] in
                await self?.fetchCharacterDataUsingAsyncAwaitApi(urlRequest: urlRequest)
            }
            tasks.append(task)
        }
    }

    func fetchCharacterDataUsingClassicApi(urlRequest: URLRequest) {
        logNetworkInfo("--- [Classic] Request started: \(urlRequest.requestPath)")
        let task = networkModule.performAndDecode(
            urlRequest: urlRequest,
            responseType: CharacterModel.self
        ) { [weak self] result in
            guard let self else { return }

            switch result {
            case let .success(character):
                logNetworkInfo("--- [Classic] Request completed: \(urlRequest.requestPath)")
                self.characters.append(character)
                self.viewState = .loaded(self.episode, self.characters)
            case let .failure(error):
                logNetworkError("--- [Classic] Request error: \(error.localizedDescription)")
                self.viewState = .error(self.episode, error)
            }
        }
        urlTasks.append(task)
    }

    func fetchCharacterDataUsingReactiveApi(urlRequest: URLRequest) {
        logNetworkInfo("--- [Reactive] Request started: \(urlRequest.requestPath)")
        networkModule
            .performAndDecode(urlRequest: urlRequest, responseType: CharacterModel.self, decoder: JSONDecoder())
            .sink(
                receiveCompletion: { [weak self, episode] completion in
                    switch completion {
                    case .finished:
                        logNetworkInfo("--- [Reactive] Subscription finished for request \(urlRequest.requestPath)")
                    case let .failure(error):
                        logNetworkError("--- [Reactive] Request error: \(error.localizedDescription)")
                        self?.viewState = .error(episode, error)
                    }
                },
                receiveValue: { [weak self, episode] characterModel in
                    logNetworkInfo("--- [Reactive] Request completed: \(urlRequest.requestPath)")
                    self?.characters.append(characterModel)
                    self?.viewState = .loaded(episode, self?.characters ?? [])
                }
            )
            .store(in: &cancellables)
    }

    func fetchCharacterDataUsingAsyncAwaitApi(urlRequest: URLRequest) async {
        logNetworkInfo("--- [Async/Await] Request started: \(urlRequest.requestPath)")
        do {
            let characterModel = try await networkModule.performAndDecode(
                urlRequest: urlRequest,
                responseType: CharacterModel.self
            )
            characters.append(characterModel)
            logNetworkInfo("--- [Async/Await] Request completed: \(urlRequest.requestPath)")
            await updateByMainActor(viewState: .loaded(episode, characters))
        } catch {
            logNetworkError("--- [Async/Await] Request error: \(error.localizedDescription)")
            await updateByMainActor(viewState: .error(episode, error))
        }
    }

    func cleanUp() {
        characters = []
        cancellables = []
        tasks.forEach { task in
            task.cancel()
        }
        urlTasks.forEach { task in
            task.cancel()
        }
        tasks = []
        urlTasks = []
    }

    func updateByMainActor(viewState: EpisodeViewState) async {
        // Discussion: Alternatively, you can just annotate `viewState` with @MainActor ...
        // ... to ensure it is updated on the Main Thread.
        await MainActor.run { [weak self] in
            self?.viewState = viewState
        }
    }
}

private extension URLRequest {

    var requestPath: String {
        url?.absoluteString ?? ""
    }
}
