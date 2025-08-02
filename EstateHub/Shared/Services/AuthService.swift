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
    ///   - completion: @escaping(AuthDataResult?, Error?) -> Void
    ///
    static func logUserIn(email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    ///
    /// Register user
    ///
    /// - Parameters:
    ///   - credentials: AuthCredentials
    ///   - completion: @escaping(Error?) -> Void
    ///
    static func registerUser(credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("Err: Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else {return}
                let data: [String: Any] = ["email": credentials.email,
                                           "profileImageURL": imageURL,
                                           "uid": uid,]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        }
    }
}
