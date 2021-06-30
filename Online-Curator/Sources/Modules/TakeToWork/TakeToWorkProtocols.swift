// 
//  TakeToWorkProtocols.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 22.05.2021.
//

import Foundation

enum TakeToWorkRoute {
    case detail(TakeToWorkItem)
}

protocol TakeToWorkRouterProtocol {
    func makeTransition(to route: TakeToWorkRoute)
}

protocol TakeToWorkViewModelProtocol: ObservableObject {
    var state: TakeToWorState { get }

    func start()
    func update(complition: @escaping () -> Void)
    func openDetail(_ item: TakeToWorkItem)
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
