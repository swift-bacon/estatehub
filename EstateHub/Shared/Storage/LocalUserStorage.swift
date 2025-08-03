//
//  LocalUserStorage.swift
//  EstateHub
//
//  Created by Unit27 on 03/08/2025.
//
import UIKit
import CoreData

struct LocalUser {
    let email: String
    let uid: String
    let avatar: UIImage?
}

class LocalUserStorage {
    
    static var context: NSManagedObjectContext? {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return delegate.persistentContainer.viewContext
    }
    
    // MARK: - Save User
    
    static func saveUser(email: String, uid: String, avatarImage: UIImage?) {
        guard let context = context else { return }
        
        // Usuń stare wpisy (dla prostoty - tylko 1 user lokalny)
        deleteUser()
        
        let userEntity = UserModel(context: context)
        userEntity.email = email
        userEntity.uid = uid
        
        if let avatar = avatarImage {
            if let filename = saveImageLocally(image: avatar, uid: uid) {
                userEntity.avatarPath = filename
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save user: \(error)")
        }
    }
    
    // MARK: - Load User
    
    static func loadUser() -> LocalUser? {
        guard let context = context else { return nil }
        let request: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        
        do {
            if let userEntity = try context.fetch(request).first {
                var avatarImage: UIImage? = nil
                if let path = userEntity.avatarPath {
                    avatarImage = loadImageFromDocuments(filename: path)
                }
                return LocalUser(email: userEntity.email!, uid: userEntity.uid!, avatar: avatarImage)
            }
        } catch {
            print("Failed to fetch user: \(error)")
        }
        return nil
    }
    
    // MARK: - Update Avatar
    
    static func updateAvatar(forEmail email: String, withImage image: UIImage) {
        guard let context = context else { return }
        let request: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        
        if let user = try? context.fetch(request).first {
            if let data = image.jpegData(compressionQuality: 0.8) {
                let filename = "avatar_\(user.uid ?? "").jpg"
                let url = getDocumentsDirectory().appendingPathComponent(filename)
                try? data.write(to: url)
                user.avatarPath = filename
                
                try? context.save()
            }
        }
    }
    
    // MARK: - Delete User
    
    static func deleteUser() {
        guard let context = context else { return }
        let request: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        
        do {
            let users = try context.fetch(request)
            for user in users {
                context.delete(user)
            }
            try context.save()
        } catch {
            print("Failed to delete user: \(error)")
        }
    }
    
    // MARK: - Helpers for saving/loading images
    
    private static func saveImageLocally(image: UIImage, uid: String) -> String? {
        let filename = "avatar_\(uid).jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        do {
            try data.write(to: url)
            return filename
        } catch {
            print("Failed to save image locally: \(error)")
            return nil
        }
    }
    
    private static func loadImageFromDocuments(filename: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return UIImage(contentsOfFile: url.path)
    }
    
    private static func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
