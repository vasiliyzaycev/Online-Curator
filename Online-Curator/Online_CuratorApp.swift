//
//  Online_CuratorApp.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 28.02.2021.
//

import SwiftUI

@main
struct Online_CuratorApp: App {
    private let assembly = Assembly()
    @ObservedObject var userProvider: UserProvider
    
    init() {
        self.userProvider = assembly.userProvider
    }
    
    var body: some Scene {
        WindowGroup {
            if let _ = userProvider.user {
                Text("Privet))")
            } else {
                LoginBuilder().build(assembly)
            }
        }
    }
}
