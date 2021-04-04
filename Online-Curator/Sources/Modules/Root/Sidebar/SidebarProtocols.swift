//
//  SidebarProtocols.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 03.04.2021.
//

import Foundation

enum SidebarRoute: Hashable, CaseIterable {
    case userSettings
    case takenToWork
    case callOrders
    case myAlerts
    case dataOnGraduates
    case agreements
    case technicalSupport
}

protocol SidebarRouterProtocol {
    func open(_ route: SidebarRoute)
    func close()
}

protocol SidebarViewModelProtocol: SidebarRouterProtocol, ObservableObject {
    var canAcceptRequests: Bool { get set }
}
