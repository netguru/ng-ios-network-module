//
//  StringExtensions.swift
//  Netguru iOS Network Module
//

import Foundation

extension String {

    var toSafeUrl: URL? {
        URL(string: replacingOccurrences(of: "http://", with: "https://"))
    }
}

extension Optional where Wrapped == String {

    func orUnknown() -> String {
        if let self {
            return self
        }
        return "---"
    }
}
