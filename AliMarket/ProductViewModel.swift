//
//  ProductViewModel.swift
//  AliMarket
//
//  Created by Nima on 6/9/23.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var products = [Product]()
    private var firestoreRefrence = Firestore.firestore().collection("Products")
    
    func addProduct(product: Product, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            var productDic = try Firestore.Encoder().encode(product)
            productDic.removeValue(forKey: "id")
            productDic.removeValue(forKey: "_id")
            firestoreRefrence.addDocument(data: productDic) { error in
                if let error = error {
                    completion(.failure(error.localizedDescription as! Error))
                } else {
                    completion(.success("succesfull"))
                }
            }
        } catch {
            completion(.failure("Error in converting to dictionary: \(error)" as! Error))
        }
    }
    
    func fetchProducts() {
        firestoreRefrence.addSnapshotListener({(querySnapshot, error) in
            guard let document = querySnapshot?.documents else {
                print("No documents...")
                return
            }
            self.products = document.compactMap({ queryDocumentSnapshot -> Product? in
                //                print(try? queryDocumentSnapshot.data(as: Product.self))
                 do {
                     print(try queryDocumentSnapshot.data(as: Product.self))
                     return try queryDocumentSnapshot.data(as: Product.self)
                 } catch {
                    print(error)
                     return Product()
                }
            })
        })
    }
    
    func updateProduct(product: Product, id: String) {
        firestoreRefrence.document(id).updateData(product.convertObjectToDictionary()) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Product updated succesfully")
            }
        }
    }
    
    func deleteProduct(id: String) {
        firestoreRefrence.document(id).delete { error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                print("Product with ID \(id) deleted")
            }
        }
    }
    
}
