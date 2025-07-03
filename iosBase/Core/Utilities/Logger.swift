//
//  Logger.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation
import os

/// A simple logging utility to output messages with different log levels.
struct Logger {
    /// Logs a message to the OS logging system with an optional log type.
    /// - Parameters:
    ///   - message: The message string to log.
    ///   - type: The log level/type (default is `.default`).
    static func log(_ message: String, type: OSLogType = .default) {
        os_log(
            "%{public}@",
            log: OSLog(
                subsystem: Bundle.main.bundleIdentifier ?? "UIKitVIPERBase",
                category: "App"
            ),
            type: type,
            message
        )
    }
}
