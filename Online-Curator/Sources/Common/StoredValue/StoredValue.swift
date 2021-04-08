//
//  StoredValue.swift
//  Online-Curator
//
//  Created by Vasiliy Zaytsev on 31.03.2021.
//

@propertyWrapper
struct StoredValue<Value: Codable> {
    private let getClosure: () throws -> Value?
    private let setClosure: (Value?) throws -> Void
    private let errorHandler: ErrorHandler

    var wrappedValue: Value? {
        get { getValue() }
        set { setValue(newValue) }
    }
    
    init<T: ValueStore, E: CertainErrorHandler>(
        valueStore: T,
        errorHandler: E
    ) where
        T.Value == Value,
        T.ErrorType == E.ErrorType
    {
        self.getClosure = valueStore.load
        self.setClosure = valueStore.save
        self.errorHandler = errorHandler
    }
    
    private func getValue() -> Value? {
        do { return try getClosure() }
        catch { errorHandler.handle(error) }
        return nil
    }
    
    private func setValue(_ value: Value?) {
        do { try setClosure(value) }
        catch { errorHandler.handle(error) }
    }
}
