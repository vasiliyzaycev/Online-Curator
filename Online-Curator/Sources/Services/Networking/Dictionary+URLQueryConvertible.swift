//
//  Dictionary+URLQueryConvertible.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 26.03.2021.
//

import Foundation

extension Dictionary: URLQueryConvertible {
    var queryItems: [URLQueryItem] {
        self.reduce([]) {
            guard let key = String(describing: $1.key).urlEncoded else {
                return $0
            }
            let value = String(describing: $1.value).urlEncoded
            return $0 + [URLQueryItem(name: key, value: value)]
        }
    }
    
    var query: String {
        queryItems.reduce([]) {
            guard let value = $1.value else { return $0 }
            return $0 + ["\($1.name)=\(value)"]
        }
        .joined(separator: "&")
    }
}

private extension String {
    var urlEncoded: String? {
        self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
