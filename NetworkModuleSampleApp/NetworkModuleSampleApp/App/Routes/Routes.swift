//
//  Routes.swift
//  NetworkModuleSampleApp


import Foundation

enum Route: Hashable {
    case home
    case episodeList(NetworkRequestType)
    case episode(requestType: NetworkRequestType, episodeId: String)
    case character
}
