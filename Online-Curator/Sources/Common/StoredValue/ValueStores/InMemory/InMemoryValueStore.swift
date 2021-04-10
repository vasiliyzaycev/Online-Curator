//
//  InMemoryValueStore.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 09.04.2021.
//

import Foundation

final class InMemoryValueStore<Value: Codable>: ValueStore {
    private var value: Value? = nil

    func save(_ value: Value?) throws {
        self.value = value
    }

    func load() throws -> Value? {
        value
    }
}
