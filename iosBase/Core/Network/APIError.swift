//
//  APIError.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

/// Represents possible errors that can occur during API requests.
enum APIError: Error {
    /// The URL provided is invalid.
    case invalidURL

    /// The response received is not valid or unexpected.
    case invalidResponse

    /// Failed to decode the data.
    case decodingError

    /// The request is unauthorized (typically 401).
    case unauthorized

    /// The request is malformed or invalid (typically 400).
    case badRequest

    /// Access to the requested resource is forbidden (typically 403).
    case forbidden

    /// The requested resource was not found (typically 404).
    case notFound

    /// A client-side error occurred with a specific status code.
    case clientError(statusCode: Int)

    /// A server-side error occurred with a specific status code.
    case serverError(statusCode: Int)

    /// The credentials provided are invalid.
    case invalidCredentials

    /// An unknown error occurred.
    case unknown
}
