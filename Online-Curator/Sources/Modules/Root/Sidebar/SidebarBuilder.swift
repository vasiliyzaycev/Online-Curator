//
//  SidebarBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 03.04.2021.
//

import SwiftUI

final class SidebarBuilder: ModuleBuilder {
    private let router: SidebarRouterProtocol

    init(router: SidebarRouterProtocol) {
        self.router = router
    }

    func build(_ assembly: Assembly) -> some View {
        SidebarView(viewModel: SidebarViewModel(router: router))
    }
}
