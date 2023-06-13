//
//  OrdersView.swift
//  AliMarket
//
//  Created by Nima on 6/9/23.
//

import SwiftUI

struct OrdersView: View {
    @ObservedObject private var orderViewModel: OrderViewModel = OrderViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List(orderViewModel.orderList, id: \.id) { order in
                    NavigationLink(destination: OrderDetailView(order: order)) {
                        OrderView(order: order)
                    }
                }
            }
            .navigationTitle("Orders")
        }
        .onAppear(perform: orderViewModel.fetchOrder)
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
