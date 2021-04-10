//
//  PersistentValueStore.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 06.04.2021.
//

import Foundation

final class PersistentValueStore<Value: Codable> {
    private let dataCoder: DataCoder
    private let dataStore: PersistentDataStore

    init(dataCoder: DataCoder, dataStore: PersistentDataStore) {
        self.dataCoder = dataCoder
        self.dataStore = dataStore
    }
}

extension PersistentValueStore: ValueStore {
    func save(_ value: Value?) throws {
        try dataStore.save(data: try data(from: value))
    }

    func load() throws -> Value? {
        try value(from: try dataStore.loadData())
    }
}

extension PersistentValueStore {
    private func data(from value: Value?) throws -> Data? {
        guard let value = value else { return nil }
        return try dataCoder.encode(value)
    }

    private func value(from data: Data?) throws -> Value? {
        guard let data = data else { return nil }
        return try dataCoder.decode(Value.self, from: data)
    }
}
