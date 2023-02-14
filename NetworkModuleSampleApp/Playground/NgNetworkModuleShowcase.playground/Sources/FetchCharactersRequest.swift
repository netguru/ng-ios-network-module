//
//  FetchCharactersRequest.swift
//  Netguru iOS Network Module
//

import Foundation
import NgNetworkModuleCore

public struct FetchCharactersRequest: NetworkRequest {
    public let path = "/character"
    public let method = NetworkRequestType.get

    public init() {}
}
