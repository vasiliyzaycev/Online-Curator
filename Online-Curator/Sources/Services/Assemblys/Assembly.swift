//
//  Assembly.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import Foundation

final class Assembly {
    lazy var userProvider: UserProvider = {
        UserProvider(
            user: userAssembly.user,
            host: host,
            loginURL: urlProvider.url(for: "login"))
    }()
    lazy var host: HostProtocol = {
        Host(baseURL: urlProvider.url(for: "baseURL"))
    }()

    private let userAssembly: UserAssemblyProtocol = UserAssembly()
    private let urlProvider: URLProviderProtocol = URLProvider()
}
