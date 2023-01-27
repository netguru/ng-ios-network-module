//
//  FakeAsynchronousOperationsExecutor.swift
//  Netguru iOS Network Module
//

import Foundation

@testable import NgNetworkModuleCore

final class FakeAsynchronousOperationsExecutor: AsynchronousOperationsExecutor {
    let type = AsynchronousExecutorType.main

    func execute(_ block: @escaping () -> Void) {
        block()
    }
}
