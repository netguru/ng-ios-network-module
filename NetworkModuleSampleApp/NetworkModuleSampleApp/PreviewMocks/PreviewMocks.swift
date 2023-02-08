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

    static let mockEpisodeRowModel = EpisodeRowModel(model: mockEpisodeModel)
    static let mockCharacterRowModel = EpisodeCharacterRowModel(id: nil, name: "Gary Junior", imageURL: nil)
    static let mockEpisodeHeaderModel = EpisodeHeaderViewModel(model: mockEpisodeModel)
}

extension PreviewMocks {

    final class EpisodeListViewModelStub: EpisodeListViewModelProtocol {
        var requestType: NetworkModuleApiType = .classic

        @Published var viewState: EpisodeListViewState = .loading
        var viewStatePublished: Published<EpisodeListViewState> { _viewState }
        var viewStatePublisher: Published<EpisodeListViewState>.Publisher { $viewState }

        func fetchData() {}
    }
}
