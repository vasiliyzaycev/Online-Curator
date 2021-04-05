//
//  UserDefaultsValueStore.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.04.2021.
//

import Foundation

enum UserDefaultsValueStoreError: Error {
    case failedSynchronize
    case storedValueTypeMismatch
}

final class UserDefaultsValueStore<Value: Codable>: ValueStore {
    private let userDefaults: UserDefaults
    private let valueKey: String

    init(
        userDefaults: UserDefaults,
        valueKey: String
    ) {
        self.userDefaults = userDefaults
        self.valueKey = valueKey
    }

    func save(_ value: Value?) throws {
        userDefaults.set(value, forKey: valueKey)
        guard userDefaults.synchronize() else {
            throw UserDefaultsValueStoreError.failedSynchronize
        }
    }

    func load() throws -> Value? {
        guard let storedValue = userDefaults.object(forKey: valueKey) else {
            return nil
        }
        guard let value = storedValue as? Value else {
            throw UserDefaultsValueStoreError.storedValueTypeMismatch
        }
        return value
    }
}
