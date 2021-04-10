//
//  PersistentValueStore.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 06.04.2021.
//

import Foundation

final class PersistentValueStore<Value: Codable> {
    private let dataStore: PersistentDataStore
    private let coder: DataCoder

    init(dataStore: PersistentDataStore, coder: DataCoder) {
        self.dataStore = dataStore
        self.coder = coder
    }
}

extension PersistentValueStore: ValueStore {
    func save(_ value: Value?) throws {
        let d = try data(from: value)
        try dataStore.save(data: d)
    }

    func load() throws -> Value? {
        try value(from: try dataStore.loadData())
    }
}

extension PersistentValueStore {
    private func data(from value: Value?) throws -> Data? {
        guard let value = value else { return nil }
        return try coder.encode(value)
    }

    private func value(from data: Data?) throws -> Value? {
        guard let data = data else { return nil }
        return try coder.decode(Value.self, from: data)
    }
}
