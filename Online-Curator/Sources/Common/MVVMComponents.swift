//
//  MVVMComponents.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
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

class Router<R: Hashable & CaseIterable>: ObservableObject {
    @Published private var currentRoute: R? = nil
    private let destinationForRoute: (R) -> AnyView
    private let completion: (() -> Void)?
    
    init(
        destinationForRoute: @escaping (R) -> AnyView,
        completion: (() -> Void)? = nil
    ) {
        self.destinationForRoute = destinationForRoute
        self.completion = completion
    }
}

extension Router: RouterProtocol {
    func makeTransition(to route: R) {
        currentRoute = route
    }

    func close() {
        currentRoute = nil //TODO this should be executed in child completion
        completion?()
    }
}

extension Router {
    func navigationView<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationView {
            content().background(navigationLinks())
        }
    }
}

extension Router {
    private func navigationLinks() -> some View {
        NavigationLinksView(router: self)
    }
    
    private struct NavigationLinksView: View {
        @ObservedObject private var router: Router<R>
        
        init(router: Router<R>) {
            self.router = router
        }
        
        var body: some View {
            Group {
                ForEach(R.allCases.map { $0 }, id: \.self) { route in
                    NavigationLink(
                        destination: router.destinationForRoute(route),
                        tag: route,
                        selection: $router.currentRoute,
                        label: {})
                }
            }
        }
    }
}

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
