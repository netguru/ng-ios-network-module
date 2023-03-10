//
//  FakeNetworkModuleAction.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModuleCore

final class FakeNetworkModuleAction: NetworkModuleAction {
    private(set) var lastRequestPreExecutionActionPerformedOn: URLRequest?
    private(set) var lastResponsePostExecutionActionPerformedOn: NetworkResponse?

    func performBeforeExecutingNetworkRequest(request: NetworkRequest?, urlRequest: inout URLRequest) {
        lastRequestPreExecutionActionPerformedOn = urlRequest
    }

    func performAfterExecutingNetworkRequest(request: NetworkRequest?, networkResponse: NetworkResponse) {
        lastResponsePostExecutionActionPerformedOn = networkResponse
    }
}
