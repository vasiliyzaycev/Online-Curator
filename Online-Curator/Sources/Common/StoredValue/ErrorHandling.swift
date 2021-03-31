//
//  ErrorHandling.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 31.03.2021.
//

protocol ErrorHandler {
    func handle(_ error: Error)
}

protocol CertainErrorHandler: ErrorHandler {
    associatedtype ErrorType: Error = Error
}

struct DefaultErrorHandler: ErrorHandler {
    func handle(_ error: Error) {
         print("Unexpected error: \(error).")
    }
}

struct StoreErrorHandler<T: Error>: CertainErrorHandler {
    let currentHandler: (T) -> Void
    let reserveHandler: ErrorHandler
    
    init(
        reserveHandler: ErrorHandler = DefaultErrorHandler(),
        _ currentHandler: @escaping (T) -> Void
    ) {
        self.reserveHandler = reserveHandler
        self.currentHandler = currentHandler
    }
    
    func handle(_ error: Error) {
        if let error = error as? T {
            currentHandler(error)
        } else {
            reserveHandler.handle(error)
        }
    }
}
