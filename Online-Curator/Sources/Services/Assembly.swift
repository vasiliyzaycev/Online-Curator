//
//  Assembly.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 05.03.2021.
//

import Foundation

final class Assembly {
    lazy var userProvider: UserProvider = {
        UserProvider(host: host, loginURL: url(for: "login"))
    }()
    lazy var host: HostProtocol = {
        Host(baseURL: url(for: "baseURL"))
    }()
    
    private var urls: [String: String] = {
        guard
            let path = Bundle.main.path(forResource: "URLs", ofType: "plist"),
            let urls = NSDictionary(contentsOfFile: path),
            let result = urls as? [String: String]
        else {
            fatalError("Error reading file URLs.plist")
        }
        return result
    }()
}

extension Assembly {
    private func url(for key: String) -> URL {
        guard
            let urlString = urls[key],
            let url = URL(string: urlString)
        else {
            fatalError("Error: missing key in URLs.plist")
        }
        return url
    }
}
