//
//  Advert.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit

struct Advert {
    let id: String?
    let name: String
    let description: String
    let address: String
    let expirationDate: String
    let isPromoted: Bool
    let price: Int

    init(id: String? = nil, name: String, description: String, address: String, expirationDate: String, isPromoted: Bool, price: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.address = address
        self.expirationDate = expirationDate
        self.isPromoted = isPromoted
        self.price = price
    }

    init?(document: [String: Any], id: String) {
        guard
            let name = document["name"] as? String,
            let description = document["description"] as? String,
            let address = document["address"] as? String,
            let expirationDate = document["expirationDate"] as? String,
            let isPromoted = document["isPromoted"] as? Bool,
            let price = document["price"] as? Int
        else { return nil }

        self.id = id
        self.name = name
        self.description = description
        self.address = address
        self.expirationDate = expirationDate
        self.isPromoted = isPromoted
        self.price = price
    }

    func toDict() -> [String: Any] {
        return [
            "name": name,
            "description": description,
            "address": address,
            "expirationDate": expirationDate,
            "isPromoted": isPromoted,
            "price": price
        ]
    }
}
