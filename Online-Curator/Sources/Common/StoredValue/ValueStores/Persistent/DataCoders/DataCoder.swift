//
//  DataCoder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 10.04.2021.
//

import Foundation

protocol DataCoder {
    func decode<T: Decodable>(_ type: T.Type, from: Data) throws -> T
    func encode<T: Encodable>(_ value: T) throws -> Data
}
