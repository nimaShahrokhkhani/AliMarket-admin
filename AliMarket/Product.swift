//
//  Product.swift
//  AliMarket
//
//  Created by Nima on 6/9/23.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Product: Codable, Hashable {
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
    var size: [String]?
    
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

struct ProductModel {
    var id: String = ""
    var name: String = ""
    var dateTime: Int = 1
    var category: Int = 0
    var price: String = ""
    var star: Int = 4
    var brand: Brand = Brand.brandList[0]
    var description: String = ""
    var type: String = ""
    var imageUrl: String = ""
    var count: String = ""
    var size: [String] = []
}

struct Brand: Codable, Hashable {
    var name: String
    var icon: String
    
    static let brandList = [
        Brand(name: "Nike", icon: "https://cdn-icons-png.flaticon.com/512/732/732229.png"),
        Brand(name: "Adidas", icon: "https://cdn-icons-png.flaticon.com/512/731/731972.png"),
        Brand(name: "Puma", icon: "https://cdn.iconscout.com/icon/free/png-256/free-puma-3421441-2853747.png")
    ]
}

enum Category: Int, CaseIterable {
    case MEN = 0;case WOMEN = 1;case KIDS = 2
}
