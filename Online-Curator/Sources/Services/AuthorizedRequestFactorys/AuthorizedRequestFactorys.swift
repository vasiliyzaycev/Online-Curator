//
//  AuthorizedRequestFactorys.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 16.05.2021.
//

import Foundation

final class AuthorizedRequestFactorys {
    private let userCredentials: UserCredentialsProtocol

    init(userCredentials: UserCredentialsProtocol) {
        self.userCredentials = userCredentials
    }
}

extension AuthorizedRequestFactorys: AuthorizedRequestFactorysProtocol {
    func createGetRequestFactory() -> RequestFactoryProtocol {
        RequestFactory(methodFactory: methodGet)
    }

    func createPostRequestFactory() -> RequestFactoryProtocol {
        RequestFactory(methodFactory: methodPost)
    }
}

extension AuthorizedRequestFactorys {
    private typealias MethodFactory = ([String: String]) -> HttpMethod

    private class RequestFactory: RequestFactoryProtocol {
        private let methodFactory: MethodFactory

        init(methodFactory: @escaping MethodFactory) {
            self.methodFactory = methodFactory
        }

        func createRequest<T: Codable>(
            url: URL,
            params: [String: String],
            headers: [String: String]
        ) -> Request<T> {
            Request(url: url, method: methodFactory(params), headers: headers)
        }

        func createRequest<T: Codable>(url: URL) -> Request<T> {
            Request(url: url, method: methodFactory([:]))
        }
    }

    private func methodGet(_ params: [String: String] = [:]) -> HttpMethod {
        return .get(authParams(params).queryItems)
    }

    private func methodPost(_ params: [String: String] = [:]) -> HttpMethod {
        let query = authParams(params).query
        let data = query.data(using: .utf8, allowLossyConversion: true)
        return .post(data)
    }

    private func authParams(_ params: [String: String]) -> [String: String] {
        var result = params
        result["id_of_specialist"] = userCredentials.id
        result["access_token"] = userCredentials.accessToken
        return result
    }
}
