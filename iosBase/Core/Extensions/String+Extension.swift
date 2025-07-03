//
//  String+Extension.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import Foundation

extension String {
    /// Checks if the string contains only alphanumeric characters without spaces.
    var isAlphanumericWithNoSpaces: Bool {
        let alphaNumSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        return rangeOfCharacter(from: alphaNumSet.inverted) == nil
    }

    /// Returns true if the string contains punctuation characters.
    var hasPunctuationCharacters: Bool {
        rangeOfCharacter(from: CharacterSet.punctuationCharacters) != nil
    }

    /// Returns true if the string contains any numeric characters.
    var hasNumbers: Bool {
        rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil
    }

    /// Returns true if the entire string is a number.
    var isNumber: Bool {
        let characters = CharacterSet.decimalDigits
        return CharacterSet(charactersIn: self).isSubset(of: characters)
    }

    /// Returns the localized version of the string.
    var localized: String {
        self.localize()
    }

    /// Localizes the string using NSLocalizedString.
    /// - Parameter comment: A comment for translators.
    /// - Returns: A localized string.
    func localize(comment: String = "") -> String {
        NSLocalizedString(self, comment: comment)
    }

    /// Returns a percent-encoded version of the string safe for filenames.
    var validFilename: String {
        guard !isEmpty else { return "emptyFilename" }
        return addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "emptyFilename"
    }

    /// Validates if the string matches the email format defined by RFC 5322.
    /// - Returns: A boolean indicating if the string is a valid email address.
    func isEmailFormatted() -> Bool {
        // swiftlint:disable line_length
        let emailRegex = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@([A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?"
        // swiftlint:enable line_length
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }
}
