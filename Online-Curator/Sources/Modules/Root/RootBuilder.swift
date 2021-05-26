//
//  RootBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 28.03.2021.
//

import SwiftUI

final class RootRouter: Router<SidebarRoute>, SidebarRouterProtocol {}

final class RootBuilder: ModuleBuilder {
    private let sidebarBuilder: SidebarBuilder
    private let router: RootRouter

    init(_ assembly: Assembly) {
        let router = RootBuilder.createRouter(assembly)
        self.sidebarBuilder = SidebarBuilder(router: router)
        self.router = router
    }

    func build(_ assembly: Assembly) -> some View {
        RootView(
            sidebarView: sidebarBuilder.build(assembly),
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
                return AnyView(TakeToWorkBuilder().build(assembly))
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
