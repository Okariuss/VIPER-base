//
//  KeychainHelper.swift
//  iosBase
//
//  Created by Okan Orkun on 31.05.2025.
//

import Foundation
import Security

/// A helper class for storing, retrieving, and deleting values in the Keychain.
final class KeychainHelper {
    static let shared = KeychainHelper()

    /// Saves a string value to the Keychain for a given key.
    /// - Parameters:
    ///   - value: The string value to save.
    ///   - key: The key associated with the value.
    func save(_ value: String, key: String) {
        guard let data = value.data(using: .utf8) else { return }

        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as CFDictionary

        // Delete any existing item before adding new
        SecItemDelete(query) // No error handling
        SecItemAdd(query, nil) // No error handling
    }

    /// Reads a string value from the Keychain for a given key.
    /// - Parameter key: The key associated with the value.
    /// - Returns: The string value if found, or nil.
    func read(key: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        guard status == errSecSuccess,
              let data = dataTypeRef as? Data,
              let result = String(data: data, encoding: .utf8) else {
            return nil
        }
        return result
    }

    /// Deletes a value from the Keychain for a given key.
    /// - Parameter key: The key associated with the value to delete.
    func delete(key: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        SecItemDelete(query) // No error handling
    }
}
