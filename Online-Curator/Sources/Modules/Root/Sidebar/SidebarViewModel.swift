//
//  SidebarViewModel.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 03.04.2021.
//

import Foundation

final class SidebarViewModel: SidebarViewModelProtocol {
    private let router: SidebarRouterProtocol
    var canAcceptRequests: Bool = false

    init(router: SidebarRouterProtocol) {
        self.router = router
    }

    func open(_ route: SidebarRoute) {
        router.open(route)
    }

    func close() {
        router.close()
    }
}
