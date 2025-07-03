//
//  AnalyticsService.swift
//  iosBase
//
//  Created by Okan Orkun on 7.06.2025.
//

@MainActor
protocol AnalyticsService {
    func setup()
    func identifyUser(with userId: String)
    func log(event: AnalyticsEvent)
    func reset()
}
