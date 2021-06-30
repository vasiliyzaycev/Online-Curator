// 
//  TakeToWorkViewModel.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 22.05.2021.
//

import Combine
import Foundation

final class TakeToWorkViewModel: TakeToWorkViewModelProtocol {
    @Published var state: TakeToWorState = .init(value: nil, state: .idle)

    private let itemsProvider: TakeToWorkItemsProviderProtocol
    private let router: TakeToWorkRouterProtocol
    private var bag: AnyCancellable?
    
    init(
        itemsProvider: TakeToWorkItemsProviderProtocol,
        router: TakeToWorkRouterProtocol
    ) {
        self.itemsProvider = itemsProvider
        self.router = router
    }

    func start() {
        updateState(.startFetch)
        update {}
    }

    func update(complition: @escaping () -> Void) {
        bag = itemsProvider
            .fetchTakeToWorkList()
            .mapError { error -> FetchError in
                switch error {
                case .networking(_):    return .network
                case .decoding(_):      return .server
                }
            }
            .sink { [weak self] complete in
                if case .failure(let error) = complete {
                    self?.updateState(.result(.failure(error)))
                }
            } receiveValue: { [weak self] items in
                self?.updateState(.result(.success(items)))
                complition()
            }
    }

    func openDetail(_ item: TakeToWorkItem) {
        router.makeTransition(to: .detail(item))
    }
}

extension TakeToWorkViewModel {
    private enum Event {
        case startFetch
        case result(Result<[TakeToWorkItem], FetchError>)
    }

    private func updateState(_ event: Event) {
        state = TakeToWorState(
            value: reduce(value: state.value, event),
            state: reduce(loadingState: state.state, event))
    }

    private func reduce(
        value: [TakeToWorkItem]?,
        _ event: Event
    ) -> [TakeToWorkItem]? {
        switch (value, event) {
        case (let value, .startFetch):
            return value
        case (let value, .result(.failure(_))):
            return value
        case (_, .result(.success(let value))):
            return value
        }
    }

    private func reduce(
        loadingState state: LoadingState<FetchError>,
        _ event: Event
    ) -> LoadingState<FetchError> {
        switch (state, event) {
        case (.idle, .startFetch):
            return .loading
        case (.loading, .result(.success(_))):
            return .idle
        case (.loading, .result(.failure(let error))):
            return .error(error)
        case (.error(_), .startFetch):
            return .loading
        case _:
            return state
        }
    }
}
