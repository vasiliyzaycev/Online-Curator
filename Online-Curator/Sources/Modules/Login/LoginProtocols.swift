//
//  LoginProtocols.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 03.04.2021.
//

import Foundation

enum LoginRoute: Hashable, CaseIterable {
    case registration
    case forgotPassword
}

protocol LoginRouterProtocol {
    func open(_ route: LoginRoute)
    func close()
}

protocol LoginViewModelProtocol: LoginRouterProtocol, ObservableObject {
    var login: String { get set }
    var password: String { get set }
    var isLoginButtonActive: Bool { get }

    func startLogin()
}
