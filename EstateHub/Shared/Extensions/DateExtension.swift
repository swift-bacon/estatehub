//
//  DateExtension.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import Foundation

extension Date {
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func isAfter(_ date: Date) -> Bool {
        return self > date
    }
    
    func isBefore(_ date: Date) -> Bool {
        return self < date
    }
}
