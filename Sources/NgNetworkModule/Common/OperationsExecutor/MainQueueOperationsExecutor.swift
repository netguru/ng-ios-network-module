//
//  MainQueueOperationsExecutor.swift
//  Netguru iOS Network Module
//

import Foundation

/// Default operations executor implementation, utilising the Main execution queue.
public final class MainQueueOperationsExecutor: AsynchronousOperationsExecutor {

    /// - SeeAlso: AsynchronousOperationsExecutor.type
    public let type = AsynchronousExecutorType.main
    
    /// A default, public initializer.
    public init() {}
}
