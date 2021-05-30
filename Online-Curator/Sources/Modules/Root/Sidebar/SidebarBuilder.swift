//
//  SidebarBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 03.04.2021.
//

import SwiftUI

final class SidebarBuilder: ModuleBuilder {
    private let assembly: Assembly
    private let router: RootRouterProtocol

    init(_ assembly: Assembly, _ router: RootRouterProtocol) {
        self.assembly = assembly
        self.router = router
    }

    func build() -> some View {
        SidebarView(
            viewModel: SidebarViewModel(
                userProvider: assembly.userProvider,
                router: router))
    }
}
