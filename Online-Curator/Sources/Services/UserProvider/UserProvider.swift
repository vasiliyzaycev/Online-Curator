//
//  UserProvider.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import Combine

protocol UserProviderProtocol {
    func start(login: String, with password: String)
    func logout()
}

class UserProvider: UserProviderProtocol, ObservableObject {
    @Published private(set) var user: User? = nil
    
    func start(login: String, with password: String) {
        user = User(login: login)
    }
    
    func logout() {
        user = nil
    }
}
