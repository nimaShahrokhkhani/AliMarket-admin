//
//  ProductView.swift
//  AliMarket
//
//  Created by Nima on 6/9/23.
//

import SwiftUI

struct ProductView: View {
    var product: Product
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.imageUrl ?? ""))
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(.gray, lineWidth: 2))
            Text(product.name ?? "")
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product.sample)
    }
}
