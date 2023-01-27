//
//  FakeNetworkResponse.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import ReactiveNgNetworkModule
@testable import NgNetworkModuleCore

struct FakeNetworkResponse: Codable, Equatable {
    let foo: String
    let bar: Int
}
