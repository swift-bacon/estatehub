//
//  ImageUploader.swift
//  EstateHub
//
//  Created by Unit27 on 01/08/2025.
//
import UIKit
import FirebaseStorage

struct ImageUploader {
    
    //
    // Upload image to firebase storage
    //
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {return}
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Err: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageURL = url?.absoluteString else {return}
                completion(imageURL)
            }
        }
    }
    
}
