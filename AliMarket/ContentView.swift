//
//  ContentView.swift
//  AliMarket
//
//  Created by Nima on 6/7/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProductsView()
                .tabItem {
                    Label("Products", systemImage: "list.dash")
                }
            OrdersView()
                .tabItem {
                    Label("Orders", systemImage: "cart.fill.badge.plus")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
