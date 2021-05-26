// 
//  TakeToWorkProtocols.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 22.05.2021.
//

import Foundation

enum TakeToWorkRoute: Hashable, CaseIterable {
    case detail
}

protocol TakeToWorkRouterProtocol {
    func openDetail(_ item: TakeToWorkItem)
}

protocol TakeToWorkViewModelProtocol: TakeToWorkRouterProtocol, ObservableObject {
    var state: TakeToWorState { get }

    func update(complition: (() -> Void)?)
    func update()
}

typealias TakeToWorState = Reloadable<[TakeToWorkItem], FetchError>

enum FetchError: Error {
    case network
    case server
}

extension FetchError {
    var description: String {
        switch self {
        case .network:  return "Ошибка связи"
        case .server:   return "Что-то пошло не так :("
        }
    }
}
