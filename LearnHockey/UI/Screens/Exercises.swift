//
//  Exercises.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 18.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine

struct Exercises: View {
    @Environment(\.locale) var locale: Locale
    @Environment(\.injected) private var injected: DIContainer
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.exercise)
    }
    var body: some View {
        Text("Hello World")
        .navigationBarTitle("Exercise")
            .fixNavigationBarBug { self.goBack() }
            .onReceive(routingUpdate) { value in
                print("test:", value)
                self.routingState = value}
    }
}

extension Exercises {
    struct Routing: Equatable {
        var exercise: String?
    }
    
    func goBack() {
        injected.appState[\.routing.exercises.exercises] = nil
    }
}

private extension Exercises {
    var routingUpdate: AnyPublisher<Routing,Never> {
        injected.appState.updates(for: \.routing.exercise)
    }
}

struct Exercises_Previews: PreviewProvider {
    static var previews: some View {
        Exercises()
    }
}
