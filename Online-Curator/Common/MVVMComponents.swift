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

final class Router<R>: ObservableObject {
    private let destinationForRoute: (R) -> AnyView
    @Published private var currentState: R? = nil
    
    init(_ destinationForRoute: @escaping (R) -> AnyView) {
        self.destinationForRoute = destinationForRoute
    }
    
    func navigationLink<Label: View>(
        to route: R,
        isActive: Binding<Bool>? = nil,
        label: () -> Label
    ) -> NavigationLink<Label, AnyView> {
        guard let isActive = isActive else {
            return NavigationLink(
                destination: destinationForRoute(route),
                label: label)
        }
        return NavigationLink(
            destination: destinationForRoute(route),
            isActive: isActive,
            label: label)
    }
}

extension Router where R: Hashable, R: CaseIterable {
    func open(_ route: R) {
        currentState = route
    }
    
    func close() {
        currentState = nil
    }
    
    func navigationWrapper<Content: View>(content: () -> Content) -> some View {
        NavigationView {
            content().background(navigationLinks())
        }
    }
}

private extension Router where R: Hashable, R: CaseIterable {
    func navigationLinks() -> some View {
        NavigationLinksView(router: self)
    }
    
    struct NavigationLinksView: View {
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
}
