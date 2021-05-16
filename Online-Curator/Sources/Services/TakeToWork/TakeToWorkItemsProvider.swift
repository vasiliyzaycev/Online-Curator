//
//  TakeToWorkItemsProvider.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 16.05.2021.
//

import Combine
import Foundation

final class TakeToWorkItemsProvider: TakeToWorkItemsProviderProtocol {
    private let host: HostProtocol
    private let requestFactory: RequestFactoryProtocol
    private let takeToWorkURL: URL

    init(
        host: HostProtocol,
        requestFactory: RequestFactoryProtocol,
        takeToWorkURL: URL
    ) {
        self.host = host
        self.requestFactory = requestFactory
        self.takeToWorkURL = takeToWorkURL
    }

    func fetchTakeToWorkList() -> AnyPublisher<[TakeToWorkItem], HostError> {
        host.publisher(for: requestFactory.createRequest(url: takeToWorkURL))
            .map { (response: [String: [TakeToWorkItem]]) in
                response["data"] ?? []
            }
            .eraseToAnyPublisher()
    }
}
