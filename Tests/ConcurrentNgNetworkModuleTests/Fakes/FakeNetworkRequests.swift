//
//  FakeNetworkRequests.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import ConcurrentNgNetworkModule
@testable import NgNetworkModule

struct FakeGetNetworkRequest: NetworkRequest {
    let path = "/welcome"
    let method = NetworkRequestType.get
}
