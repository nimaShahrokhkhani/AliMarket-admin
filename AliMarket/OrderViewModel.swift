//
//  OrderViewModel.swift
//  AliMarket
//
//  Created by Nima on 6/12/23.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class OrderViewModel: ObservableObject {
    @Published var orderList = [Order]()
    private var firestoreRefrence = Firestore.firestore().collection("Order")
    
    func fetchOrder() {
        firestoreRefrence.addSnapshotListener({querySnapshot, error in
            guard let document = querySnapshot?.documents else {
                return
            }
            self.orderList = document.compactMap({ queryDocumentSnapshot -> Order in
                do {
                    print(try queryDocumentSnapshot.data(as: Order.self).productList)
                    return try queryDocumentSnapshot.data(as: Order.self)
                } catch {
                    print(error)
                    return Order()
                }
            })
        })
        
    }

    func updateOrder(order: Order, id: String, completion: @escaping (Result<String, Error>) -> Void) {
        firestoreRefrence.document(id).updateData(order.convertObjectToDictionary()) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(id))
            }
            
        }
    }
}
