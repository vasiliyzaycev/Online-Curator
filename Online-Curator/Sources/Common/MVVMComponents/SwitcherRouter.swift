//
//  SwitcherRouter.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 01.06.2021.
//

import SwiftUI

class SwitcherRouter<R: Hashable & CaseIterable>: ObservableObject {
    @Published private(set) var currentRoute: R
    private let completion: (() -> Void)?

    init(
        route: R,
        completion: (() -> Void)? = nil
    ) {
        self.currentRoute = route
        self.completion = completion
    }
}

extension SwitcherRouter: RouterProtocol {
    func makeTransition(to route: R) {
        currentRoute = route
    }

    func close() {
        completion?()
    }
}
