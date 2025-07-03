//
//  NetworkService.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation
import Network

// MARK: - Empty Response
struct EmptyResponse: Codable { }

// MARK: - HTTP Method Enum
/// Enum representing supported HTTP methods for network requests.
enum HTTPMethod: String {
    /// GET request.
    case get = "GET"
    
    /// POST request.
    case post = "POST"
    
    /// PUT request.
    case put = "PUT"
    
    /// DELETE request.
    case delete = "DELETE"
    
    /// PATCH request.
    case patch = "PATCH"
}

// MARK: - Network Service Protocol
protocol NetworkServiceProtocol {
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T
    var isConnected: Bool { get }
}

// MARK: - Network Service Implementation
final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Singleton
    static let shared = NetworkService()
    private init() {
        startMonitoring()
    }

    // MARK: - Properties
    private let monitor = NWPathMonitor()
    private var isConnectedToInternet: Bool = false
    
    nonisolated var isConnected: Bool {
        return isConnectedToInternet
    }

    // MARK: - Public Request Method
    func request<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        do {
            return try await makeRequest(endpoint: endpoint)
        } catch APIError.unauthorized {
            try await refreshTokenIfNeeded()
            return try await makeRequest(endpoint: endpoint)
        }
    }

    // MARK: - Core Request
    private func makeRequest<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        let request: URLRequest
        do {
            request = try endpoint.urlRequest()
        } catch {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            break // Success
        case 400:
            throw APIError.badRequest
        case 401:
            throw APIError.unauthorized
        case 403:
            throw APIError.forbidden
        case 404:
            throw APIError.notFound
        case 400...499:
            throw APIError.clientError(statusCode: httpResponse.statusCode)
        case 500...599:
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        default:
            throw APIError.unknown
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }

    // MARK: - Refresh Token
    private func refreshTokenIfNeeded() async throws {
        let endpoint = APIEndpoint.refreshToken
        let response: LoginResponse = try await makeRequest(endpoint: endpoint)
        SessionManager.shared.saveAccessToken(response.accessToken)
        SessionManager.shared.saveRefreshToken(response.refreshToken)
    }

    // MARK: - Network Connectivity Monitor
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnectedToInternet = path.status == .satisfied
        }
        monitor.start(queue: DispatchQueue(label: "NetworkMonitor"))
    }
}
