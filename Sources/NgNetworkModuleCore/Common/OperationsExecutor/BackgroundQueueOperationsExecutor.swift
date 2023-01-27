//
//  BackgroundQueueOperationsExecutor.swift
//  Netguru iOS Network Module
//

import Foundation

/// Default operations executor implementation, utilising concurrent background execution queue.
public final class BackgroundQueueOperationsExecutor: AsynchronousOperationsExecutor {

    /// - SeeAlso: AsynchronousOperationsExecutor.type
    public let type = AsynchronousExecutorType.backgroundConcurrent

    /// A default, public initializer.
    public init() {}
}
