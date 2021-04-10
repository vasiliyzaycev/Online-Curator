//
//  PersistentDataStore.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 10.04.2021.
//

import Foundation

protocol PersistentDataStore {
    func save(data: Data?) throws
    func loadData() throws -> Data?
}
