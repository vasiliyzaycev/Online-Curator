//
//  UserProviderProtocols.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 26.03.2021.
//

import Foundation

protocol UserProviderProtocol {
    func start(
        login: String,
        with password: String,
        complition: @escaping (HostError?) -> Void)
    func logout()
}

protocol UserCredentialsProtocol {
    var id: String { get }
    var accessToken: String { get }
}
