//
//  LoginBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 06.03.2021.
//

import SwiftUI

final class LoginRouter: Router<LoginRoute>, LoginRouterProtocol {}

final class LoginBuilder: ModuleBuilder {
    private let assembly: Assembly
    private lazy var router: LoginRouter = {
        LoginRouter { route in
            switch route {
            case .registration:
                return AnyView(Text("Экран регистрации"))
            case .forgotPassword:
                return AnyView(Text("Экран восстановления пароля"))
            }
        }
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
