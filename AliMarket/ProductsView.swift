//
//  ProductsView.swift
//  AliMarket
//
//  Created by Nima on 6/9/23.
//

import SwiftUI

struct ProductsView: View {
    @ObservedObject private var productViewModel: ProductViewModel = ProductViewModel()    
    var body: some View {
        NavigationView {
            VStack{
                List(productViewModel.products, id: \.hashValue) { product in
                    NavigationLink(destination: ItemDetail(product: product)) {
                        ProductView(product: product)
                    }
                }
                .listStyle(.grouped)
            }
            .navigationBarTitle("Products", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddProduct()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear(perform: productViewModel.fetchProducts)
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
