//
//  MVVMProtocols.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 01.06.2021.
//

import SwiftUI

protocol ModuleBuilder {
    associatedtype V: View

    func build() -> V
}

protocol RouterProtocol {
    associatedtype R

    func makeTransition(to route: R)
    func close()
}
