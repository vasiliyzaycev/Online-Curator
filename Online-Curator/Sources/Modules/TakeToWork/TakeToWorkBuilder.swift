// 
//  TakeToWorkBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 22.05.2021.
//

import SwiftUI

final class TakeToWorkRouter:
    Router<TakeToWorkRoute, AnyView>,
    TakeToWorkRouterProtocol {}

final class TakeToWorkBuilder: ModuleBuilder {
    private let assembly: Assembly
    private lazy var router: TakeToWorkRouter = {
        TakeToWorkRouter { route in
            switch route {
            case .detail(let item):
                return AnyView(Color.yellow
                    .navigationBarTitle("Мои оповещения", displayMode: .inline))
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
            .background(router.navigationLinksView())
    }
}
