//
//  DateExtension.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import Foundation

extension Date {
    
    ///
    /// Date to string
    ///
    /// - Parameter format: String
    /// - Returns: String
    ///
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    ///
    /// Check is date after
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    ///
    func isAfter(_ date: Date) -> Bool {
        return self > date
    }
    
    ///
    /// Check is date before
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    ///
    func isBefore(_ date: Date) -> Bool {
        return self < date
    }
    
}
