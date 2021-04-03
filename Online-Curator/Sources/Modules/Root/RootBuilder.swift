//
//  RootBuilder.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 28.03.2021.
//

import SwiftUI

final class RootBuilder: ModuleBuilder {
    func build(_ assembly: Assembly) -> some View {
        RootView(
            sideBarView: SideBarBuilder().build(assembly),
            mainView: MainBuilder().build(assembly))
    }
}


final class SideBarBuilder: ModuleBuilder {
    func build(_ assembly: Assembly) -> some View {
        HStack {
            VStack {
                Text("SideBar")
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color("SideBarBackgroundColor"))
    }
}

final class MainBuilder: ModuleBuilder {
    func build(_ assembly: Assembly) -> some View {
        Text("Privet))")
    }
}
