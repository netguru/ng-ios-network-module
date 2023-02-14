//
//  LogNetworkModuleAction.swift
//  Netguru iOS Network Module
//

import Foundation
import NgNetworkModuleCore

public class LogNetworkModuleAction: NetworkModuleAction {

    public init() {}

    public func performBeforeExecutingNetworkRequest(request: NetworkRequest?, urlRequest: inout URLRequest) {
        print("--- Executing request: \(urlRequest)")
    }

    public func performAfterExecutingNetworkRequest(request: NetworkRequest?, networkResponse: NetworkResponse) {
        print("*** Received response code: \(networkResponse.networkResponse.statusCode)")
    }
}
