//
//  URLProvider.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 10.04.2021.
//

import Foundation

final class URLProvider: URLProviderProtocol {
    private var urls: [String: URL] = loadURLs()

    func url(for key: String) -> URL {
        guard let url = urls[key] else {
            fatalError("Error: missing key in URLs.plist")
        }
        return url
    }
}

extension URLProvider {
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
