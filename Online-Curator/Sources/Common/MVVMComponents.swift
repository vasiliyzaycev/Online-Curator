//
//  MVVMComponents.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import SwiftUI

protocol ModuleBuilder {
    associatedtype V: View
    
    func build(_ : Assembly) -> V
}

protocol RouterProtocol {
    associatedtype R

    func open(_ route: R)
    func close()
}

class Router<R: Hashable & CaseIterable>: ObservableObject {
    @Published private var currentState: R? = nil
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
    func open(_ route: R) {
        currentState = route
    }

    func close() {
        currentState = nil //TODO this should be executed in child completion
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

    func routingView() -> some View {
        RoutingView(router: self)
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
                        selection: $router.currentState,
                        label: {})
                }
            }
        }
    }

    private struct RoutingView: View {
        @ObservedObject private var router: Router<R>

        init(router: Router<R>) {
            self.router = router
        }

        var body: some View {
            router.currentDestination()
        }
    }
}

private extension Router {
    func currentDestination() -> AnyView {
        guard let state = currentState else { return AnyView(EmptyView()) }
        return destinationForRoute(state)
    }
}
