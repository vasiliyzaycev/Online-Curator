//
//  TakeToWorkItemsProviderProtocol.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 16.05.2021.
//

import Combine
import Foundation

protocol TakeToWorkItemsProviderProtocol {
    func fetchTakeToWorkList() -> AnyPublisher<[TakeToWorkItem], HostError>
}
