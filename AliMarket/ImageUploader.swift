//
//  ImageUploader.swift
//  AliMarket
//
//  Created by Nima on 6/11/23.
//
import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import FirebaseStorage

class ImageUploader: ObservableObject {
    @Published var progress: Progress = Progress()
    func uploadImage(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(ImageError.invalidImageData))
            return
        }
        let storageRef = Storage.storage().reference()
        let imageName = UUID().uuidString + ".jpg"
        let imageRef = storageRef.child("images/\(imageName)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let updateTask = imageRef.putData(imageData, metadata: metadata)
        
        updateTask.observe(.progress) { snapshot in
            guard let progress = snapshot.progress else {return}
            DispatchQueue.main.async { [weak self] in
                self?.progress = progress
            }
        }
        
        updateTask.observe(.success) { snapshot in
            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let downloadUrl = url {
                    completion(.success(downloadUrl))
                } else {
                    completion(.failure(ImageError.downloadURLNotFound))
                }
            }
        }
        
        updateTask.observe(.failure) {snapshot in
            if let error = snapshot.error {
                completion(.failure(error))
            }
        }
        
        
    }
    
    enum ImageError: Error {
        case invalidImageData
        case downloadURLNotFound
    }
}

