//
//  PreviewMocks.swift
//  Netguru iOS Network Module
//

import Foundation
import NgNetworkModuleCore

enum PreviewMocks {
    static let mockEpisodeModel = EpisodeModel(
        id: 0,
        name: "Chapter 1",
        airDate: "01/12/2023",
        director: "John Doe",
        writer: "Jane Doe",
        characters: [],
        imageURL: ""
    )
    static let mockCharacterModel = CharacterModel(
        id: Int.random(in: 0...1000),
        name: "Character",
        status: "active",
        species: "human",
        gender: "male",
        hair: "",
        alias: [],
        origin: "Earth",
        abilities: ["leadership"],
        imageURL: ""
    )

    static let mockEpisodeViewData = EpisodeViewData(episode: mockEpisodeModel, selectedNetworkApi: .classic)
    static let mockCharacterRowModel = CharacterViewData(id: 0, name: "Gary Junior", imageURL: nil)
}

extension PreviewMocks {

    final class EpisodeListViewModelStub: EpisodeListViewModelProtocol {
        var selectedNetworkApi: NetworkModuleApiType = .classic

        @Published var viewState: EpisodeListViewState = .loading
        var viewStatePublished: Published<EpisodeListViewState> { _viewState }
        var viewStatePublisher: Published<EpisodeListViewState>.Publisher { $viewState }

        func fetchData() {}
    }

    final class EpisodeViewModelStub: EpisodeViewModelProtocol {
        var selectedNetworkingAPI: NetworkModuleApiType = .classic

        @Published var viewState: EpisodeViewStates = .loading(PreviewMocks.mockEpisodeModel)
        var viewStatePublished: Published<EpisodeViewStates> { _viewState }
        var viewStatePublisher: Published<EpisodeViewStates>.Publisher { $viewState }

        @Published var characters: [CharacterModel] = []
        var charactersPublished: Published<[CharacterModel]> { _characters }
        var charactersPublisher: Published<[CharacterModel]>.Publisher { $characters }

        func fetchData() {}
    }
}
