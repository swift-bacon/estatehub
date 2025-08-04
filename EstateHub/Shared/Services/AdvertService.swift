//
//  AdvertService.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import FirebaseFirestore

enum AdvertService {
    
    static private let db = Firestore.firestore().collection("adverts")

    // MARK: - Add
    
    ///
    /// Add new advert
    /// - Parameter advert: Advert
    ///
    static func add(advert: Advert) async throws {
        let data: [String: Any] = [
            "name": advert.name,
            "description": advert.description,
            "address": advert.address,
            "expirationDate": advert.expirationDate
        ]
        _ = try await db.addDocument(data: data)
    }

    // MARK: - Fetch
    
    ///
    /// Fetch adverts list
    /// - Returns: [Advert]
    ///
    static func fetch() async throws -> [Advert] {
        let snapshot = try await db.getDocuments()
        return snapshot.documents.map { doc in
            let data = doc.data()
            return Advert(
                id: doc.documentID,
                name: data["name"] as? String ?? "",
                description: data["description"] as? String ?? "",
                address: data["address"] as? String ?? "",
                expirationDate: data["expirationDate"] as? String ?? "",
                isPromoted: data["isPromoted"] as? Bool ?? false
            )
        }
    }

    // MARK: - Update
    
    ///
    /// Update advert after edit
    /// - Parameter advert: Advert
    ///
    static func update(advert: Advert) async throws {
        guard let id = advert.id else { throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing document ID"]) }
        
        let data: [String: Any] = [
            "name": advert.name,
            "description": advert.description,
            "address": advert.address,
            "expirationDate": advert.expirationDate,
            "isPromoted": advert.isPromoted,
        ]
        try await db.document(id).updateData(data)
    }

    // MARK: - Delete
    
    ///
    /// Delete advert
    /// - Parameter advertID: String
    ///
    static func delete(advertID: String) async throws {
        try await db.document(advertID).delete()
    }
}
