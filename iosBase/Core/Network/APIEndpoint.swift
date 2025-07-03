//
//  APIEndpoint.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

/// Defines all API endpoints used in the application.
enum APIEndpoint {
    case login(email: String, password: String)
    case signup(email: String, password: String, name: String)
    case refreshToken
    case logout
    case resetPassword(email: String)

    /// Returns the relative path for each endpoint.
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .signup:
            return "/signup"
        case .refreshToken:
            return "/refresh-token"
        case .logout:
            return "/logout"
        case .resetPassword:
            return "/reset-password"
        }
    }

    /// Returns the HTTP method for each endpoint.
    var method: HTTPMethod {
        switch self {
        case .login, .signup, .refreshToken, .logout, .resetPassword:
            return .post
        }
    }

    /// Returns HTTP headers, including authorization if required.
    var headers: [String: String] {
        var baseHeaders = ["Content-Type": "application/json"]

        switch self {
        case .refreshToken:
            baseHeaders["Authorization"] = "Bearer \(SessionManager.shared.refreshToken)"
        default:
            break
        }

        return baseHeaders
    }

    /// Returns the HTTP body as JSON data if needed.
    var body: Data? {
        switch self {
        case .login(let email, let password):
            let params = ["email": email, "password": password]
            return try? JSONSerialization.data(withJSONObject: params)
        case .signup(let email, let password, let name):
            let params = ["email": email, "password": password, "name": name]
            return try? JSONSerialization.data(withJSONObject: params)
        case .refreshToken:
            let token = SessionManager.shared.refreshToken
            let params = ["token": token]
            return try? JSONSerialization.data(withJSONObject: params)
        case .logout:
            return nil
        case .resetPassword(let email):
            let params = ["email": email]
            return try? JSONSerialization.data(withJSONObject: params)
        }
    }

    /// Builds and returns a URLRequest from the endpoint configuration.
    /// - Throws: APIError.invalidURL if the base URL or path is malformed.
    func urlRequest() throws -> URLRequest {
        guard let url = URL(string: "\(AppEnvironment.baseURL)\(path)") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
}
