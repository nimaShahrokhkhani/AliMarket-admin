//
//  OrderView.swift
//  AliMarket
//
//  Created by Nima on 6/12/23.
//

import SwiftUI

struct OrderView: View {
    var order: Order?
    var body: some View {
        HStack {
            Image("checklist")
                .resizable()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                HStack {
                    Text("User: ")
                    Text(order?.email ?? "")
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                }
                HStack {
                    Text("Order Id: ")
                    Text(order?.id ?? "")
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                }
                HStack {
                    Text("Date Time: ")
                    Text(Date(timeIntervalSince1970: TimeInterval((order?.dateTime ?? 0) / 1000)), style: .date)
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                }
            }
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
