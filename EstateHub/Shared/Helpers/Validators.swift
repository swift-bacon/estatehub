//
//  Validators.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import Foundation

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
}

func isPasswordValid(_ password: String) -> Bool {
    return true
}
