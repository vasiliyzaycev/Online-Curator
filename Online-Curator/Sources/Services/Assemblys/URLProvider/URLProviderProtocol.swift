//
//  URLProviderProtocol.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 10.04.2021.
//

import Foundation

protocol URLProviderProtocol {
    func url(for key: String) -> URL
}
