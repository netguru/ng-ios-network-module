//
//  EpisodeViewModelProtocol.swift
//  NetworkModuleSampleApp

import SwiftUI

protocol EpisodeViewModelProtocol: AnyObject, ObservableObject {
    var requestType: NetworkRequestType { get }
    
    /// Episode Publisher Properties
    var episode: EpisodeModel { get }
    var episodePublished: Published<EpisodeModel> { get }
    var episodePublisher: Published<EpisodeModel>.Publisher { get }
    
    /// Character Publisher Properties
    var characters: [CharacterModel] { get }
    var charactersPublished: Published<[CharacterModel]> { get }
    var charactersPublisher: Published<[CharacterModel]>.Publisher { get }
    
    func fetchData(with episodeId: String)
}

