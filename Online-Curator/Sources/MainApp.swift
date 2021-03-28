//
//  StartApp.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 28.02.2021.
//

import SwiftUI

@main
struct OnlineCuratorApp: App {
    private let assembly = Assembly()
    @ObservedObject var userProvider: UserProvider
    
    init() {
        self.userProvider = assembly.userProvider
    }
    
    var body: some Scene {
        WindowGroup {
            if let _ = userProvider.user {
                RootBuilder().build(assembly)
            } else {
                LoginBuilder().build(assembly)
            }
        }
    }
}
