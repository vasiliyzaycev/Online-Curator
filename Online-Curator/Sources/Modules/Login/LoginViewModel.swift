//
//  LoginViewModel.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 07.03.2021.
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

final class LoginViewModel: LoginViewModelProtocol {
    @Published var login: String = ""
    @Published var password: String = ""
    var isLoginButtonActive: Bool { isValidEmail(login) && !password.isEmpty }
    
    private let userProvider: UserProviderProtocol
    private let router: LoginRouterProtocol
    
    init(
        userProvider: UserProviderProtocol,
        router: LoginRouterProtocol
    ) {
        self.userProvider = userProvider
        self.router = router
    }
    
    func startLogin() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.userProvider.start(login: self.login, with: self.password)
        }
    }
    
    func open(_ route: LoginRoute) {
        router.open(route)
    }
    
    func close() {
        router.close()
    }
}

private extension LoginViewModel {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\" +
            ".[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08" +
            "\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\" +
            "x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[" +
            "(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0" +
            "-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[" +
            "\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|" +
            "\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
