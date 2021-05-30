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
}

protocol RootRouterProtocol {
    func makeTransition(to route: RootRoute)
    func close()
}
