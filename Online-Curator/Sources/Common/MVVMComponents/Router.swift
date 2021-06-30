//
//  Router.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import SwiftUI

class Router<R, V: View>: ObservableObject {
    @Published fileprivate var currentRoute: R? = nil
    private let destinationForRoute: (R) -> V
    private let completion: (() -> Void)?
    
    init(
        @ViewBuilder destinationForRoute: @escaping (R) -> V,
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
    func navigationLinksView() -> some View {
        RouterView(router: self)
    }

    func navigationView<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationView {
            content().background(navigationLinksView())
        }
    }
}

extension Router {
    private struct RouterView: View {
        @ObservedObject private var router: Router<R, V>
        @Binding private var isActive: Bool

        init(router: Router<R, V>) {
            self.router = router
            self._isActive = Binding<Bool>(
                get: {
                    guard let _ = router.currentRoute else { return false }
                    return true
                },
                set: { isActive in
                    if !isActive {
                        router.close()
                    }
                }
            )
        }

        var body: some View {
            NavigationLink(
                destination: content(),
                isActive: $isActive,
                label: {})
        }

        @ViewBuilder
        private func content() -> some View {
            if let route = router.currentRoute {
                router
                    .destinationForRoute(route)
                    .edgesIgnoringSafeArea(.bottom)
                    .navigationBarColor(UIColor(named: "NavBarBackgroundColor"))
            } else {
                EmptyView()
            }
        }
    }
}
