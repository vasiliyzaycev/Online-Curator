// 
//  TakeToWorkBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 22.05.2021.
//

import SwiftUI

final class TakeToWorkRouter: Router<TakeToWorkRoute>, TakeToWorkRouterProtocol {
    func openDetail(_ item: TakeToWorkItem) {
        //TODO
    }
}

final class TakeToWorkBuilder: ModuleBuilder {
    private let assembly: Assembly
    private lazy var router: TakeToWorkRouter = {
        TakeToWorkRouter { route in
            switch route {
            case .detail:
                return AnyView(Color.yellow)
            }
        }
    }()

    init(_ assembly: Assembly) {
        self.assembly = assembly
    }
    
    func build() -> some View {
        TakeToWorkView(
            viewModel: TakeToWorkViewModel(
                itemsProvider: assembly.takeToWorkItemsProvider,
                router: router))
    }
}
