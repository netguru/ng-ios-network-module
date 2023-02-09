//
//  HomeRowType.swift
//  Netguru iOS Network Module
//

import SwiftUI

enum HomeRowType: String {
    case classic, combine, asyncawait

    var rowTitle: String {
        switch self {
        case .classic: return "Classic Method Request"
        case .combine: return "Combine Method Request"
        case .asyncawait: return "Async/Await Method Request"
        }
    }

    var rowSubTitle: String {
        switch self {
        case .classic: return "Sample Explanation about Classic Network Request"
        case .combine: return "Sample Explanation about Combine Network Request"
        case .asyncawait: return "Sample Explanation about AsyncAwait Network Request"
        }
    }

    var rowImageName: String {
        switch self {
        case .classic: return "network"
        case .combine: return "square.on.square.intersection.dashed"
        case .asyncawait: return "scribble"
        }
    }

    var rowImageColor: Color {
        switch self {
        case .classic: return .blue
        case .combine: return .green
        case .asyncawait: return .indigo
        }
    }

    var viewModelType: NetworkModuleApiType {
        switch self {
        case .classic:
            return .classic
        case .combine:
            return .combine
        case .asyncawait:
            return .asyncAwait
        }
    }
}
