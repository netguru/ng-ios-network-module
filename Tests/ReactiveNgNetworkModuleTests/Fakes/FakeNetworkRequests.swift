//
//  FakeNetworkRequests.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import ReactiveNgNetworkModule
@testable import NgNetworkModule

struct FakeGetNetworkRequest: NetworkRequest {
    let path = "/welcome"
    let method = NetworkRequestType.get
}
