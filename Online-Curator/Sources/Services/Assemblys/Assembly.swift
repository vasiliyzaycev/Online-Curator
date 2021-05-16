//
//  Assembly.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import Foundation

final class Assembly {
    lazy var takeToWorkItemsProvider: TakeToWorkItemsProviderProtocol = {
        TakeToWorkItemsProvider(
            host: host,
            requestFactory: getRequestFactory,
            takeToWorkURL: urlProvider.url(for: "takeToWork"))
    }()
    lazy var userProvider: UserProvider = {
        UserProvider(
            user: userAssembly.user,
            host: host,
            loginURL: urlProvider.url(for: "login"))
    }()
    lazy var host: HostProtocol = {
        Host(baseURL: urlProvider.url(for: "baseURL"))
    }()

    private lazy var getRequestFactory: RequestFactoryProtocol = {
        requestFactorys.createGetRequestFactory()
    }()
    private lazy var postRequestFactory: RequestFactoryProtocol = {
        requestFactorys.createPostRequestFactory()
    }()
    private lazy var requestFactorys: AuthorizedRequestFactorysProtocol = {
        AuthorizedRequestFactorys(userCredentials: userProvider)
    }()
    private let userAssembly: UserAssemblyProtocol = UserAssembly()
    private let urlProvider: URLProviderProtocol = URLProvider()
}
