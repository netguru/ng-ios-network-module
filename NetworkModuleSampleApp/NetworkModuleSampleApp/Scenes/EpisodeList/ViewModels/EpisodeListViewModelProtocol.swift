//
//  EpisodeListViewModelProtocol.swift
//  Netguru iOS Network Module
//

import SwiftUI

enum NetworkModuleApiType: Equatable {
    case classic
    case combine
    case asyncAwait
}

enum EpisodeListViewState: Equatable {
    case loading
    case noData
    case loaded([EpisodeModel])
    /// Could be created Custom error model
    case error(Error)

    static func == (lhs: EpisodeListViewState, rhs: EpisodeListViewState) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData),
             (.loading, .loading):
            return true
        case let (.error(e1), .error(e2)):
            return e1.localizedDescription == e2.localizedDescription
        case let (.loaded(data1), .loaded(data2)):
            return data1 == data2
        default:
            return false
        }
    }
}

protocol EpisodeListViewModelProtocol: AnyObject, ObservableObject {
    var selectedNetworkApi: NetworkModuleApiType { get }
    var viewState: EpisodeListViewState { get }
    var viewStatePublished: Published<EpisodeListViewState> { get }
    var viewStatePublisher: Published<EpisodeListViewState>.Publisher { get }
    func fetchData()
}
