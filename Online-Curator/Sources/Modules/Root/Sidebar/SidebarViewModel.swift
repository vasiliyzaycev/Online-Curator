//
//  SidebarViewModel.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 03.04.2021.
//

import Foundation

final class SidebarViewModel: SidebarViewModelProtocol {
    var canAcceptRequests: Bool = false

    private let userProvider: UserProviderProtocol
    private let router: SidebarRouterProtocol

    init(
        userProvider: UserProviderProtocol,
        router: SidebarRouterProtocol
    ) {
        self.userProvider = userProvider
        self.router = router
    }

    func open(_ route: SidebarRoute) {
        router.open(route)
    }

    func close() {
        userProvider.logout()
    }
}
