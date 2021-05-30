//
//  RootBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 28.03.2021.
//

import SwiftUI

final class RootRouter: SwitcherRouter<RootRoute>, RootRouterProtocol {}

final class RootBuilder: ModuleBuilder {
    private let assembly: Assembly
    private let router: RootRouter

    init(_ assembly: Assembly) {
        self.assembly = assembly
        self.router = RootRouter(route: .userSettings)
    }

    func build() -> some View {
        SidebarSkeletonView(
            sidebarView: SidebarBuilder(assembly, router).build(),
            contentView: RootContentView(assembly, router))
    }
}

extension RootBuilder {
    private struct RootContentView: View {
        private let assembly: Assembly
        @ObservedObject private var router: RootRouter

        init(_ assembly: Assembly, _ router: RootRouter) {
            self.assembly = assembly
            self.router = router
        }

        var body: some View {
            switch router.currentRoute {
            case .userSettings:
                return AnyView(Color.red)
            case .takenToWork:
                return AnyView(TakeToWorkBuilder(assembly).build())
            case .callOrders:
                return AnyView(Color.green)
            case .myAlerts:
                return AnyView(Color.orange)
            case .dataOnGraduates:
                return AnyView(Color.pink)
            case .agreements:
                return AnyView(Color.purple)
            case .technicalSupport:
                return AnyView(Color.black)
            }
        }
    }
}
