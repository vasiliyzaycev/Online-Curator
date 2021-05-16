//
//  NetworkProtocols.swift
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

protocol RequestFactoryProtocol {
    func createRequest<T: Codable>(
        url: URL,
        params: [String: String],
        headers: [String: String]
    ) -> Request<T>

    func createRequest<T: Codable>(url: URL) -> Request<T>
}

struct Request<Response> {
    let url: URL
    let method: HttpMethod
    let headers: [String: String]

    init(
        url: URL,
        method: HttpMethod,
        headers: [String: String] = [:]
    ) {
        self.url = url
        self.method = method
        self.headers = headers
    }
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

enum HostError: Error {
    case networking(URLError)
    case decoding(Error)
}

protocol URLQueryConvertible {
    var queryItems: [URLQueryItem] { get }
    var query: String { get }
}
