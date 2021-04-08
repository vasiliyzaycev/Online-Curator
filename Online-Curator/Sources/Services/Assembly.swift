//
//  Assembly.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import Foundation

final class Assembly {
    lazy var userProvider: UserProvider = {
        UserProvider(user: user, host: host, loginURL: url(for: "login"))
    }()
    lazy var host: HostProtocol = {
        Host(baseURL: url(for: "baseURL"))
    }()

    private lazy var user: StoredValue<User> = {
        var rez = StoredValue(
            valueStore: userValueStore,
            errorHandler: userStoreErrorHandler)
        rez.wrappedValue = nil
        return rez
    }()
    private lazy var userValueStore = {
        PersistentValueStore<User>(dataStore: userDataStore)
    }()
    private lazy var userStoreErrorHandler = {
        StoreErrorHandler { (error: UserDefaultsDataStoreError) in
            switch error {
            case .failedSynchronize:
                print("Failed synchronize UserDefaults")
            case .storedDataTypeMismatch:
                print("Stored value type mismatch in UserDefaults")
            }
        }
    }()
    private lazy var userDataStore = {
        UserDefaultsDataStore(
            userDefaults: UserDefaults.standard,
            valueKey: "stored_user")
    }()
    private var urls: [String: URL] = loadURLs()
}

extension Assembly {
    private func url(for key: String) -> URL {
        guard let url = urls[key] else {
            fatalError("Error: missing key in URLs.plist")
        }
        return url
    }
    
    private static func loadURLs() -> [String: URL] {
        guard
            let path = Bundle.main.path(forResource: "URLs", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path),
            let stringURLs = dictionary as? [String: String]
        else {
            fatalError("Error reading file URLs.plist")
        }
        let urls = stringURLs.compactMapValues { URL(string: $0) }
        guard urls.count == stringURLs.count else {
            fatalError("Error converting string from URLs.plist file to URL")
        }
        return urls
    }
}
