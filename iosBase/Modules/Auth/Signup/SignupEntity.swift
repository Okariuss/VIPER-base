//
//  SignupEntity.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

/// Represents the data required to perform a signup request.
struct SignupRequest: Codable {
    let username: String
    let email: String
    let password: String
    let confirmPassword: String
}
