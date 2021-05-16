//
//  UserProvider.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import Combine
import Foundation

final class UserProvider: ObservableObject, UserCredentialsProtocol {
    @StoredValue
    var user: User? { willSet { objectWillChange.send() } }
    var id: String {
        guard let user = user else { fatalError("User is not logged in") }
        return user.id
    }
    var accessToken: String {
        guard let user = user else { fatalError("User is not logged in") }
        return user.accessToken
    }

    private let host: HostProtocol
    private let loginURL: URL
    private var bag: AnyCancellable? = nil
    
    init(
        user: StoredValue<User>,
        host: HostProtocol,
        loginURL: URL
    ) {
        self._user = user
        self.host = host
        self.loginURL = loginURL
    }
}

extension UserProvider: UserProviderProtocol {
    func start(
        login: String,
        with password: String,
        complition: @escaping (HostError?) -> Void
    ) {
        let request = createRequest(login, password)
        bag = host.publisherForArrayWrappedValue(for: request)
            .handleEvents(receiveOutput: { [weak self] in
                guard let self = self else { return }
                self.user = $0
            })
            .ignoreOutput()
            .eraseToAnyPublisher()
            .sink {
                switch $0 {
                case .failure(let error):   complition(error)
                case .finished:             complition(nil)
                }
            } receiveValue: { _ in }
    }
    
    func logout() {
        user = nil
    }
}

private extension UserProvider {
    private func createRequest(
        _ login: String,
        _ password: String
    ) -> Request<User> {
        let bodyString = ["email": login, "password": password].query
        let data = bodyString.data(using: .utf8, allowLossyConversion: true)
        return Request(url: loginURL, method: .post(data))
    }
}
