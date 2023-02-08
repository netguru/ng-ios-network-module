//
//  GetEpisodesListRequest.swift
//  Netguru iOS Network Module
//

import Foundation
import NgNetworkModuleCore

struct GetEpisodesListRequest: NetworkRequest {
    let path = "/v0/episode/"
    let method = NetworkRequestType.get
}
