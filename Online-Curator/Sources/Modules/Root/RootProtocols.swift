//
//  RootProtocols.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 03.04.2021.
//

import Foundation

enum RootRoute: Hashable, CaseIterable {
    case userSettings
    case takenToWork
    case callOrders
    case myAlerts
    case dataOnGraduates
    case agreements
    case technicalSupport
    case logout
}

protocol RootRouterProtocol {
    func open(_ route: RootRoute)
    func close()
}

protocol RootViewModelProtocol: RootRouterProtocol, ObservableObject {
    var canAcceptRequests: Bool { get set }

    func logout()
}
