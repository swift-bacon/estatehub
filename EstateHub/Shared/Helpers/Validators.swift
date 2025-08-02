//
//  Validators.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import Foundation

///
/// <#Description#>
///
/// - Parameter email: String
/// - Returns: Bool
///
func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
}

///
/// Is password valid
///
/// - Parameter password: String
/// - Returns: Bool
///
func isPasswordValid(_ password: String) -> Bool {
    let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password.trimmingCharacters(in: .whitespaces))
}
