//
//  Logging.swift
//  Netguru iOS Network Module
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier ?? "NgNetworkModuleSampleApp"

    /// Networking logs.
    static let networking = OSLog(subsystem: subsystem, category: "networking")
}

func logNetworkInfo(_ message: String) {
    log(message: message, category: .networking)
}

func logNetworkError(_ message: String) {
    log(message: message, category: .networking, type: .error)
}

private func log(message: String, category: OSLog, type: OSLogType = .info) {
    os_log("%{public}@", log: category, type: type, message)
}
