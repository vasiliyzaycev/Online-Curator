//
//  LoginViewModel.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 07.03.2021.
//

import Combine
import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    @Published var state: LoginViewModelState = .prohibited
    @Published var login: String = ""
    @Published var password: String = ""
    
    private let userProvider: UserProviderProtocol
    private let router: LoginRouterProtocol
    private var bag = Set<AnyCancellable>()
    
    init(
        userProvider: UserProviderProtocol,
        router: LoginRouterProtocol
    ) {
        self.userProvider = userProvider
        self.router = router
        $login
            .combineLatest($password)
            .sink { [weak self] (login, password) in
                guard let self = self else { return }
                let isValid = self.isValidEmail(login) && !password.isEmpty
                self.updateState(.updateCredentials(isValid))
            }
            .store(in: &bag)
    }
    
    func startLogin() {
        updateState(.login)
        userProvider.start(login: login, with: password) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.updateState(.showError(error))
            } else {
                self.updateState(.success)
            }
        }
    }

    func hideAlert() {
        updateState(.hideError)
    }
    
    func open(_ route: LoginRoute) {
        router.open(route)
    }
}

extension LoginViewModel {
    private enum Action {
        case updateCredentials(Bool)
        case login
        case success
        case showError(HostError)
        case hideError
    }

    private func updateState(_ action: Action) {
        state = reduce(state, action)
    }

    private func reduce(
        _ state: LoginViewModelState,
        _ action: Action
    ) -> LoginViewModelState {
        switch (state, action) {
        case (.prohibited, .updateCredentials(let isValid)),
             (.allowed, .updateCredentials(let isValid)):
            return isValid ? .allowed : .prohibited
        case (.allowed, .login):
            return .processing
        case (.processing, .success):
            return .allowed
        case (.processing, .showError(_)):
            return .error("Что-то пошло не так")
        case (.error, .hideError):
            return .allowed
        case (let state, let action):
            assertionFailure("Invalid state: \(state) for action: \(action)")
            return state
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
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
