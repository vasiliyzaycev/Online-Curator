//
//  JSONCoder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 09.04.2021.
//

import Foundation

final class JSONCoder: DataCoder {
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.decoder = decoder
        self.encoder = encoder
    }

    func decode<T: Decodable>(_ type: T.Type, from: Data) throws -> T {
        try decoder.decode(type, from: from)
    }

    func encode<T: Encodable>(_ value: T) throws -> Data {
        try encoder.encode(value)
    }
}
