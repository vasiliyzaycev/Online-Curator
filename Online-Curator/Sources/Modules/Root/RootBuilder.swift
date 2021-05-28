//
//  RootBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 28.03.2021.
//

import SwiftUI

final class RootRouter: Router<SidebarRoute>, SidebarRouterProtocol {}

final class RootBuilder: ModuleBuilder {
    private let assembly: Assembly
    private let sidebarBuilder: SidebarBuilder
    private let router: RootRouter

    init(_ assembly: Assembly) {
        self.assembly = assembly
        let router = RootBuilder.createRouter(assembly)
        self.sidebarBuilder = SidebarBuilder(assembly, router)
        self.router = router
    }

    func build() -> some View {
        RootView(
            sidebarView: sidebarBuilder.build(),
            mainView: router.routingView())
    }
}


extension RootBuilder {
    static private func createRouter(_ assembly: Assembly) -> RootRouter {
        RootRouter { route in
            switch route {
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
