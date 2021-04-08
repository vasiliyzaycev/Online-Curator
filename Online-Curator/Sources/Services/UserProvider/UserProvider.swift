//
//  UserProvider.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import Combine
import Foundation

final class UserProvider: ObservableObject {
    @StoredValue
    var user: User? { willSet { objectWillChange.send() } }

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
    func start(login: String, with password: String) {
        let request = createRequest(login, password)
        bag = host.publisherForArrayWrappedValue(for: request)
            .sink {
                //TODO: Refactor this
                switch $0 {
                case .failure(.decoding(let error)):
                    print(error.localizedDescription)
                case .failure(.networking(let error)):
                    print(error.localizedDescription)
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] in
                guard let self = self else { return }
                self.user = $0
            }
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
