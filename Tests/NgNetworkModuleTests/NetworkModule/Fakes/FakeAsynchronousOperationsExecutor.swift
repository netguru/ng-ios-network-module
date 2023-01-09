//
//  FakeAsynchronousOperationsExecutor.swift
//  Netguru iOS Network Module
//

import UIKit

@testable import NgNetworkModule

final class FakeAsynchronousOperationsExecutor: AsynchronousOperationsExecutor {
    let type = AsynchronousExecutorType.main

    func execute(_ block: @escaping () -> Void) {
        block()
    }
}
