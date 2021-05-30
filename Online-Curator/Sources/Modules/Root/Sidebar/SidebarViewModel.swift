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
    private let router: RootRouterProtocol

    init(
        userProvider: UserProviderProtocol,
        router: RootRouterProtocol
    ) {
        self.userProvider = userProvider
        self.router = router
    }

    func makeTransition(to route: RootRoute) {
        router.makeTransition(to: route)
    }

    func close() {
        userProvider.logout()
    }
}
