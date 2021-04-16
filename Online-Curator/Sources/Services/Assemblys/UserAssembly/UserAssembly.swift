//
//  UserAssembly.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 10.04.2021.
//

import Foundation

final class UserAssembly: UserAssemblyProtocol {
    lazy var user: StoredValue<User> = {
        StoredValue(
            valueStore: createValueStore(),
            errorHandler: createErrorHandler())
    }()
}

extension UserAssembly {
    private typealias UserDefaultsErrorHandler
        = StoreErrorHandler<UserDefaultsDataStoreError>

    private func createValueStore() -> PersistentValueStore<User> {
        PersistentValueStore<User>(
            dataCoder: JSONCoder(),
            dataStore: createDataStore())
    }

    private func createErrorHandler() -> UserDefaultsErrorHandler {
        StoreErrorHandler { (error: UserDefaultsDataStoreError) in
            switch error {
            case .failedSynchronize:
                print("Failed synchronize UserDefaults")
            case .storedDataTypeMismatch:
                print("Stored value type mismatch in UserDefaults")
            }
        }
    }

    private func createDataStore() -> PersistentDataStore {
        UserDefaultsDataStore(
            userDefaults: UserDefaults.standard,
            valueKey: "stored_user")
    }
}
