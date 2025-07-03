//
//  User.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import UIKit
import FirebaseAuth

/// A struct representing a user object with basic identity information.
struct User: Codable {
    let id: String
    let name: String
    let email: String
}

extension User {
    /// Initializes a `User` instance from a `FirebaseAuth.User` object.
    /// - Parameter firebaseUser: The Firebase user to convert.
    init(from firebaseUser: FirebaseAuth.User) {
        self.id = firebaseUser.uid
        self.name = firebaseUser.displayName ?? ""
        self.email = firebaseUser.email ?? ""
    }
}
