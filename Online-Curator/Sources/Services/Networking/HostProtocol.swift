//
//  HostProtocol.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 22.03.2021.
//

import Combine
import Foundation

protocol HostProtocol {
    func publisher<Value: Decodable>(
        for request: Request<Value>
    ) -> AnyPublisher<Value, HostError>
    
    func publisher<Value: Decodable>(
        for request: Request<Value>,
        using decoder: JSONDecoder
    ) -> AnyPublisher<Value, HostError>
    
    func publisherForArrayWrappedValue<Value: Decodable>(
        for request: Request<Value>
    ) -> AnyPublisher<Value, HostError>
    
    func publisher(
        for request: Request<Data>
    ) -> AnyPublisher<Data, HostError>
}

struct Request<Response> {
    let url: URL
    let method: HttpMethod
    var headers: [String: String] = [:]
}

enum HttpMethod: Equatable {
    case get([URLQueryItem])
    case post(Data?)

    var name: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

enum HostError: Swift.Error {
    case networking(URLError)
    case decoding(Swift.Error)
}

protocol URLQueryConvertible {
    var queryItems: [URLQueryItem] { get }
    var query: String { get }
}
