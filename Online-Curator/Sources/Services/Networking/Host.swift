//
//  NetworkHost.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 22.03.2021.
//

import Combine
import Foundation

class Host {
    private let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL) {
        self.baseURL = baseURL
        self.session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: nil,
            delegateQueue: OperationQueue.main)
    }
}

extension Host: HostProtocol {
    func publisher<Value: Decodable>(
        for request: Request<Value>
    ) -> AnyPublisher<Value, HostError> {
        session.publisher(for: createURLRequest(from: request))
    }
    
    func publisher<Value: Decodable>(
        for request: Request<Value>,
        using decoder: JSONDecoder
    ) -> AnyPublisher<Value, HostError> {
        session.publisher(for: createURLRequest(from: request), using: decoder)
    }
    
    func publisherForArrayWrappedValue<Value: Decodable>(
        for request: Request<Value>
    ) -> AnyPublisher<Value, HostError> {
        session.publisherForArrayWrappedValue(
            for: createURLRequest(from: request))
    }
    
    func publisher(
        for request: Request<Data>
    ) -> AnyPublisher<Data, HostError> {
        session.publisher(for: createURLRequest(from: request))
    }
}

extension Host {
    private func createURLRequest<Value: Decodable>(
        from request: Request<Value>
    ) -> URLRequest {
        request.urlRequest(baseURL)
    }
}

private extension Request {
    func urlRequest(_ baseURL: URL) -> URLRequest {
        switch method {
        case .post(let data):
            var request = createURLRequest(url: createURL(baseURL))
            request.httpBody = data
            return request
        case .get(let queryItems):
            let optionalComponents = URLComponents(
                url: createURL(baseURL),
                resolvingAgainstBaseURL: false)
            guard var components = optionalComponents else {
                preconditionFailure("Couldn't create a components from url...")
            }
            components.queryItems = queryItems
            guard let url = components.url else {
                preconditionFailure("Couldn't create a url from components...")
            }
            return createURLRequest(url: url)
        }
    }
    
    private func createURL(_ baseURL: URL) -> URL {
        let optionalURL = URL(string: url.absoluteString, relativeTo: baseURL)
        guard let url = optionalURL else {
            preconditionFailure("Couldn't create a url...")
        }
        return url.absoluteURL
    }
    
    private func createURLRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.name
        return request
    }
}

private extension URLSession {
    func publisher<Value: Decodable>(
        for request: URLRequest,
        using decoder: JSONDecoder = .init()
    ) -> AnyPublisher<Value, HostError> {
        publisher(for: request)
            .decode(type: Value.self, decoder: decoder)
            .mapError(HostError.decoding)
            .eraseToAnyPublisher()
    }
    
    func publisherForArrayWrappedValue<Value: Decodable>(
        for request: URLRequest,
        using decoder: JSONDecoder = .init()
    ) -> AnyPublisher<Value, HostError> {
        publisher(for: request)
            .decode(type: [Value].self, decoder: decoder)
            .mapError(HostError.decoding)
            .flatMap { wrappedValue -> AnyPublisher<Value, HostError> in
                guard let value = wrappedValue.first else {
                    let error = DecodingError.valueNotFound(
                        Value.self,
                        .init(codingPath: [], debugDescription: "empty array"))
                    return Fail(
                        outputType: Value.self,
                        failure: HostError.decoding(error))
                        .eraseToAnyPublisher()
                }
                return Just(value)
                    .setFailureType(to: HostError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func publisher(
        for request: URLRequest
    ) -> AnyPublisher<Data, HostError> {
         dataTaskPublisher(for: request)
            .mapError(HostError.networking)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
