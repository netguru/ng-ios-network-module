//
//  BackgroundQueueOperationsExecutor.swift
//  Netguru iOS Network Module
//

import Foundation

/// Default operations executor implementation, utilising concurrent background execution queue.
final class BackgroundQueueOperationsExecutor: AsynchronousOperationsExecutor {

    /// - SeeAlso: AsynchronousOperationsExecutor.type
    let type = AsynchronousExecutorType.backgroundConcurrent

    /// A default, public initializer.
    public init() {}
}
