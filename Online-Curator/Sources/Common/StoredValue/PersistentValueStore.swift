//
//  PersistentValueStore.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 06.04.2021.
//

import Foundation

protocol PersistentDataStore {
    func save(data: Data?) throws
    func loadData() throws -> Data?
}

final class PersistentValueStore<Value: Codable>: ValueStore {
    private let dataStore: PersistentDataStore

    init(dataStore: PersistentDataStore) {
        self.dataStore = dataStore
    }

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
        return try JSONEncoder().encode(value)  //TODO remove concrete Encoder
    }

    private func value(from data: Data?) throws -> Value? {
        guard let data = data else { return nil }
        return try JSONDecoder().decode(Value.self, from: data) //TODO remove concrete Decoder
    }
}
