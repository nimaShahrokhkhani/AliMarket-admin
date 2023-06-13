//
//  ItemDetail.swift
//  AliMarket
//
//  Created by Nima on 6/9/23.
//

import SwiftUI

struct ItemDetail: View {
    var product: Product
    var body: some View {
        ScrollView(.vertical) {
            AsyncImage(url: URL(string: product.imageUrl ?? "")) {image in
                image.image?
                    .resizable()
                    .scaledToFit()
            }
            Text(product.description ?? "")
            Spacer()
        }
        .navigationTitle(product.name ?? "")
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail(product: Product())
    }
}
