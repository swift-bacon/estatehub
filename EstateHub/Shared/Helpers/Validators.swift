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
/// - Returns: String?
///
func isPasswordValid(_ password: String) -> String? {
    if password.count < 8 {
        return "Password must be at least 8 characters long"
    }
    
    if password.range(of: "[A-Z]", options: .regularExpression) == nil {
        return "Password must contain at least one uppercase letter"
    }
    
    if password.range(of: "[a-z]", options: .regularExpression) == nil {
        return "Password must contain at least one lowercase letter"
    }
    
    if password.range(of: "[0-9]", options: .regularExpression) == nil {
        return "Password must contain at least one number"
    }
    
    if password.range(of: "[#?!@$%^&<>*~:`-]", options: .regularExpression) == nil {
        return "Password must contain at least one special character"
    }
    
    return nil
}
