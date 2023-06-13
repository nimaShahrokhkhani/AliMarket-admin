//
//  AliMarketApp.swift
//  AliMarket
//
//  Created by Nima on 6/7/23.
//

import SwiftUI
import FirebaseCore
import Firebase

@main
struct AliMarketApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
