//
//  UserProviderProtocol.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 26.03.2021.
//

import Foundation

protocol UserProviderProtocol {
    func start(login: String, with password: String)
    func logout()
}
