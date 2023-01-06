//
//  AsynchronousExecutorType.swift
//  Netguru iOS Network Module
//

import Foundation

/// An enumeration describing properties of an executor queue.
public enum AsynchronousExecutorType: Equatable {

    /// Main queue.
    case main

    /// Background, concurrent queue.
    case backgroundConcurrent
}

public extension AsynchronousExecutorType {

    /// A convenience field creating a queue based on an executor type.
    var queue: DispatchQueue {
        switch self {
        case .main:
            return DispatchQueue.main
        case .backgroundConcurrent:
            return DispatchQueue(label: "AsyncExecutorBackgroundQueue", attributes: .concurrent)
        }
    }
}
