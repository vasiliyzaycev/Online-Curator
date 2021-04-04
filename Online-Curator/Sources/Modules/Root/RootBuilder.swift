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

    init() {
        self.router = RootRouter { route in
            switch route {
            case .userSettings:
                return AnyView(Color.red)
            case .takenToWork:
                return AnyView(Color.blue)
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
        self.sidebarBuilder = SidebarBuilder(router: router)
    }

    func build(_ assembly: Assembly) -> some View {
        RootView(
            sidebarView: sidebarBuilder.build(assembly),
            mainView: router.routingView())
    }
}
