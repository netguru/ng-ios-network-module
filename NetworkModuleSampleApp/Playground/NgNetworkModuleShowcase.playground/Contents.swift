//
//  Contents.swift
//  Netguru iOS Network Module
//

import UIKit
import NgNetworkModuleCore
import ReactiveNgNetworkModule
import ConcurrentNgNetworkModule
import Combine

//  Setup:
let baseUrl = URL(string: "https://finalspaceapi.com/api/v0")!
let requestBuilder = DefaultRequestBuilder(baseURL: baseUrl)
let action = LogNetworkModuleAction()
let networkModule = DefaultNetworkModule(
    requestBuilder: requestBuilder,
    actions: [action]
)
let request = FetchCharactersRequest()

//  Using classical network module:
networkModule.performAndDecode(request: request, responseType: [FetchCharactersResponse].self) { result in
    switch result {
    case let .success(response):
        print("+++")
        print("+++ [Classical] Request suceeded, response: \(response.map { $0.name })")
        print("+++")
    case let .failure(error):
        print("!!!")
        print("!!! [Classical] Request failed: \(error)")
        print("!!!")
    }
}

//  Using reactive network module:
var cancellables: Set<AnyCancellable> = []
networkModule
    .performAndDecode(request: request, responseType: [FetchCharactersResponse].self)
    .sink { completion in
        switch completion {
        case let .failure(error):
            print("!!!")
            print("!!! [Reactive] Request failed: \(error)")
            print("!!!")
        case .finished:
            print("--- subscription finished")
        }
    } receiveValue: { response in
        print("+++")
        print("+++ [Reactive] Request suceeded, response: \(response.map { $0.name })")
        print("+++")
    }
    .store(in: &cancellables)

//  Using async / await newtork module:
Task {
    do {
        let response = try await networkModule.performAndDecode(
            request: request,
            responseType: [FetchCharactersResponse].self
        )
        print("+++")
        print("+++ [Async/Await] Request suceeded, response: \(response.map { $0.name })")
        print("+++")
    } catch {
        print("!!!")
        print("!!! [Async/Await] Request failed: \(error)")
        print("!!!")
    }
}
