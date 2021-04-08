//
//  UserDefaultsDataStore.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.04.2021.
//

import Foundation

enum UserDefaultsDataStoreError: Error {
    case failedSynchronize
    case storedDataTypeMismatch
}

final class UserDefaultsDataStore: PersistentDataStore {
    private let userDefaults: UserDefaults
    private let valueKey: String

    init(
        userDefaults: UserDefaults,
        valueKey: String
    ) {
        self.userDefaults = userDefaults
        self.valueKey = valueKey
    }

    func save(data: Data?) throws {
        userDefaults.set(data, forKey: valueKey)
        guard userDefaults.synchronize() else {
            throw UserDefaultsDataStoreError.failedSynchronize
        }
    }

    func loadData() throws -> Data? {
        guard let object = userDefaults.object(forKey: valueKey) else {
            return nil
        }
        guard let data = object as? Data else {
            throw UserDefaultsDataStoreError.storedDataTypeMismatch
        }
        return data
    }
}
