//
//  LoginEntity.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

/// Represents the data required to perform a login request.
struct LoginRequest: Codable {
    let email: String
    let password: String
}

/// Represents the response received after a successful login.
struct LoginResponse: Codable {
    let user: User
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
}
