//
//  LoadableState.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 22.05.2021.
//

import Foundation

enum Loadable<T, E: Error> {
    case initial(LoadingState<E>)
    case value(T)
}

struct Reloadable<T, E: Error> {
    let value: T?
    let state: LoadingState<E>
}

extension Reloadable {
    var asTuple: (T?, LoadingState<E>) { (value, state) }
}

enum LoadingState<E: Error> {
    case idle
    case loading
    case error(E)
}
