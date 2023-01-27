//
//  PreviewMocks.swift
//  Netguru iOS Network Module
//

import Foundation

enum PreviewMocks {
    static let mockEpisodeModel = EpisodeModel(id: "",
                                               name: "Chapter 1",
                                               airDate: "01/12/2023",
                                               director: "John Doe",
                                               writer: "Jane Doe",
                                               characters: [],
                                               imageURL: "")

    static let mockEpisodeRowModel = EpisodeRowModel(model: mockEpisodeModel)
    static let mockCharacterRowModel = EpisodeCharacterRowModel(id: nil,
                                                                name: "Gary Junior",
                                                                imageURL: nil)
}
