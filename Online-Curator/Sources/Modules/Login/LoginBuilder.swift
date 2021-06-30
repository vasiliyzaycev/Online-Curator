//
//  LoginBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 06.03.2021.
//

import SwiftUI

final class LoginRouter<V: View>: Router<LoginRoute, V>, LoginRouterProtocol {}

final class LoginBuilder: ModuleBuilder {
    private let assembly: Assembly
    private lazy var router: LoginRouter<LoginRouterView> = {
        LoginRouter { route in LoginRouterView(route) }
    }()

    init(_ assembly: Assembly) {
        self.assembly = assembly
    }

    func build() -> some View {
        router.navigationView {
            LoginView(
                viewModel: LoginViewModel(
                    userProvider: assembly.userProvider,
                    router: router))
        }
    }
}

extension LoginBuilder {
    private struct LoginRouterView: View {
        private let route: LoginRoute

        init(_ route: LoginRoute) {
            self.route = route
        }

        var body: some View {
            switch route {
            case .registration:     Text("Экран регистрации")
            case .forgotPassword:   Text("Экран восстановления пароля")
            }
        }
    }
}
