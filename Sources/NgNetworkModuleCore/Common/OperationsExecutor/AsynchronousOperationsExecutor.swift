//
//  AsynchronousOperationsExecutor.swift
//  Netguru iOS Network Module
//

import Foundation

/// An abstraction allowing to execute blocks of code asynchronously.
public protocol AsynchronousOperationsExecutor {

    /// Executor type.
    var type: AsynchronousExecutorType { get }

    /// Executes provided code block on predefined execution queue.
    /// - Parameter block: code block to be executed.
    func execute(_ block: @escaping () -> Void)
}

extension AsynchronousOperationsExecutor {

    /// - SeeAlso: AsynchronousOperationsExecutor.execute()
    public func execute(_ block: @escaping () -> Void) {
        type.queue.async {
            block()
        }
    }
}
