//
//  LoginProtocols.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 03.04.2021.
//

import Foundation

enum LoginRoute {
    case registration
    case forgotPassword
}

protocol LoginRouterProtocol {
    func makeTransition(to route: LoginRoute)
}

enum LoginViewModelState: Equatable {
    case prohibited
    case allowed
    case processing
    case error(String)
}

protocol LoginViewModelProtocol: LoginRouterProtocol, ObservableObject {
    var state: LoginViewModelState { get }
    var login: String { get set }
    var password: String { get set }

    func startLogin()
    func hideAlert()
}
