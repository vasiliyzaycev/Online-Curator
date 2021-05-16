//
//  AuthorizedRequestFactorysProtocol.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 16.05.2021.
//

import Foundation

protocol AuthorizedRequestFactorysProtocol {
    func createGetRequestFactory() -> RequestFactoryProtocol
    func createPostRequestFactory() -> RequestFactoryProtocol
}
