//
//  Order.swift
//  AliMarket
//
//  Created by Nima on 6/12/23.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Order: Codable, Hashable {
    @DocumentID var id: String?
    var productList: [ProductCart]?
    var email: String?
    var dateTime: Int?
    
    func convertObjectToDictionary() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary = [String: Any]()
        
        for (key, value) in mirror.children {
            if let key = key {
                dictionary[key] = value
            }
        }
        
        return dictionary
    }
    
    static let sample = Product(id: "123", name: "test", dateTime: 123, category: 0, price: 100, star: 4,  description: "I love this product", type: "Shoe", imageUrl: "", count: 20, size: ["xl"])
}

struct ProductCart: Codable, Hashable {
    @DocumentID var id: String?
    var name: String?
    var dateTime: Int?
    var category: Int?
    var price: Double?
    var star: Int?
    var isMyFavourit: Bool?
    var brand: Brand?
    var description: String?
    var type: String?
    var imageUrl: String?
    var count: Int?
    var size: String?
}
