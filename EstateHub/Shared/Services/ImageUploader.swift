//
//  ImageUploader.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit
import FirebaseStorage

struct ImageUploader {
    
    ///
    /// Upload Image
    ///
    /// - Parameters:
    ///   - image: UIImage
    ///   - completion: @escaping(String) -> Void
    ///
    static func uploadImage(image: UIImage) async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            let filename = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")

            guard let imageData = image.jpegData(compressionQuality: 0.75) else {
                continuation.resume(throwing: NSError(domain: "Upload", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"]))
                return
            }

            ref.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                ref.downloadURL { url, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let url = url {
                        continuation.resume(returning: url.absoluteString)
                    }
                }
            }
        }
    }
    
}
