//
//  AuthService.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import FirebaseAuth
import FirebaseFirestoreInternal

struct AuthService {
    
    ///
    /// Log user in
    ///
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    ///
    static func logUserIn(email: String, password: String) async throws -> AuthDataResult {
        return try await withCheckedThrowingContinuation { continuation in
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let result = result {
                    continuation.resume(returning: result)
                } else {
                    continuation.resume(throwing: NSError(domain: "UnknownError", code: -1))
                }
            }
        }
    }
    
    ///
    /// Register user
    ///
    /// - Parameters:
    ///   - credentials: AuthCredentials
    ///   - completion: @escaping(Error?) -> Void
    ///
    static func registerUser(credentials: AuthCredentials) async throws {
        
//        var imageUrl: String?
//        
//        if (credentials.profileImage != nil) {
//            imageUrl = try await ImageUploader.uploadImage(image: credentials.profileImage!)
//        }
//        
        let authResult: AuthDataResult = try await withCheckedThrowingContinuation { continuation in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let result = result {
                    continuation.resume(returning: result)
                } else {
                    continuation.resume(throwing: NSError(domain: "Register", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown registration error"]))
                }
            }
        }

        let uid = authResult.user.uid

        let userData: [String: Any] = [
            "email": credentials.email,
            "profileImageURL": "",
            "uid": uid
        ]

        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume()
                }
            }
        }
    }
    
    ///
    /// Logout
    ///
    static func logOut() throws {
        try Auth.auth().signOut()
    }
}
