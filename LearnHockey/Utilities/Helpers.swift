//
//  Helpers.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 10.11.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

// MARK: - Combine Helpers

// Should have called it "CVS Store"
typealias Store<State> = CurrentValueSubject<State, Never>




 // MARK: - Publisher Extensions

extension Publisher {
    func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default: break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
    
    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { subscriptionCompletion in
            if let error = subscriptionCompletion.error {
                completion(.failed(error))
            }
        }, receiveValue: { value in
            completion(.loaded(value))
        })
    }
    
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure> {
        mapError {
            ($0.underlyingError as? Failure) ?? $0
        }
    }
}

extension Publisher {
    func flatMap<Wrapped,Some: Publisher, None: Publisher>(
        ifSome: @escaping (Wrapped) -> Some,
        ifNone: @escaping () -> None
    ) -> AnyPublisher<Some.Output,Failure>
        where Output == Optional<Wrapped>, Some.Output == None.Output, Some.Failure == Failure, None.Failure == Failure {
            return self.flatMap {
                $0.map { ifSome($0).eraseToAnyPublisher() }  ?? ifNone().eraseToAnyPublisher()}
                .eraseToAnyPublisher()
    }
}

extension Publisher where Output == Bool {
    func flatMap<True: Publisher, False: Publisher>(
        ifTrue: @escaping () -> True,
        ifFalse: @escaping () -> False
    ) -> AnyPublisher<True.Output, Failure>
        where True.Output == False.Output, True.Failure == Failure, False.Failure == Failure
    {
        return self
            .flatMap { return $0 ? ifTrue().eraseToAnyPublisher() : ifFalse().eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
}


private extension Error {
    var underlyingError: Error? {
        let nsError = self as NSError
        if nsError.domain == NSURLErrorDomain && nsError.code == -1009 {
            // "The Internet connection appears to be offline."
            return self
        }
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}

// MARK: - CurrentValueSubject Extensions

extension CurrentValueSubject {
    
    subscript<T>(keyPath: WritableKeyPath<Output, T>) -> T where T: Equatable {
        get { value[keyPath: keyPath] }
        set {
            var value = self.value
            if value[keyPath: keyPath] != newValue {
                value[keyPath: keyPath] = newValue
                self.value = value
            }
        }
    }
    
    func bulkUpdate(_ update: (inout Output) -> Void) {
        var value = self.value
        update(&value)
        self.value = value
    }
    
    func updates<Value>(for keyPath: KeyPath<Output, Value>) ->
        AnyPublisher<Value, Failure> where Value: Equatable {
            return map(keyPath).removeDuplicates().eraseToAnyPublisher()
    }
}




extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}

// MARK: - SwiftUI Helpers

extension Binding where Value: Equatable {
    func dispatched<State>(to state: Store<State>,
                           _ keyPath: WritableKeyPath<State, Value>) -> Self {
        return .init(get: { () -> Value in
            self.wrappedValue
        }, set: { value in
            self.wrappedValue = value
            state[keyPath] = value
        })
    }
}

// MARK: - General

extension ProcessInfo {
    var isRunningTests: Bool {
        environment["XCTestConfigurationFilePath"] != nil
    }
}



// MARK: - View Inspection helper

internal final class Inspection<V> where V: View {
    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()
    
    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}
