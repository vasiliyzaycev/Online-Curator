//
//  SidebarProtocols.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 03.04.2021.
//

import Foundation

protocol SidebarViewModelProtocol: RootRouterProtocol, ObservableObject {
    var canAcceptRequests: Bool { get set }
}
