//
//  EpisodeListViewModelProtocol.swift
//  NetworkModuleSampleApp

import SwiftUI

enum NetworkRequestType: Equatable {
    case classic
    case combine
    case asyncAwait
}

protocol EpisodeListViewModelProtocol: AnyObject, ObservableObject {
    var requestType: NetworkRequestType { get }
    var episodeList: EpisodeListModel { get }
    var episodeListPublished: Published<EpisodeListModel> { get }
    var episodeListPublisher: Published<EpisodeListModel>.Publisher { get }
    func fetchData()
}
