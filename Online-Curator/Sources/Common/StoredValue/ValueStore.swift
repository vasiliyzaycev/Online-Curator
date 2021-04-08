//
//  ValueStore.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 31.03.2021.
//

protocol ValueStore {
    associatedtype Value: Codable
    associatedtype ErrorType: Error = Error

    func save(_ value: Value?) throws
    func load() throws -> Value?
}
