//
//  AnalyticsEvent.swift
//  iosBase
//
//  Created by Okan Orkun on 7.06.2025.
//

struct AnalyticsEvent {
    let name: String
    let parameters: [String: Any]?

    init(name: String, parameters: [String: Any]? = nil) {
        self.name = name
        self.parameters = parameters
    }
}
