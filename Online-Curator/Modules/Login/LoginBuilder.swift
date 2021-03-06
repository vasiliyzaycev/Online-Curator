//
//  LoginBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 06.03.2021.
//

import SwiftUI

enum LoginRoute: Hashable, CaseIterable {
    case registration
    case forgotPassword
}

final class LoginBuilder: ModuleBuilder {
    func build(_ assembly: Assembly) -> LoginView {
        LoginView(router: Router { (route: LoginRoute) -> AnyView in
            switch route {
            case .registration:
                return AnyView(Text("Экран регистрации"))
            case .forgotPassword:
                return AnyView(Text("Экран восстановления пароля"))
            }
        })
    }
}
