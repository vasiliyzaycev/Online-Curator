//
//  UserProvider.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import Combine

class UserProvider: ObservableObject {
    @Published private(set) var user: User? = nil
    
    func login(_ login: String, password: String) {
        user = User(login: login)
    }
    
    func logout() {
        user = nil
    }
}
