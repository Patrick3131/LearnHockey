//
//  Exercises.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 18.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine

struct ExercisesView: View {
    let category: Category
    
    @Environment(\.locale) var locale: Locale
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var exercises: Loadable<[Exercise]>
    
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.exercises)
    }
    
    init(category:Category, exercises: Loadable<[Exercise]> = .notRequested) {
        self.category = category
        self._exercises = .init(initialValue: exercises)
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

private extension ExercisesView {
    func loadExercises() {
        injected.interactors.exerciseInteractor.loadExercises(exercises: $exercises, category: category)
    }
}

extension ExercisesView {
    struct Routing: Equatable {
        var exercise: String?
    }
    
    func goBack() {
        injected.appState[\.routing.categories.categories] = nil
    }
}

private extension ExercisesView {
    var routingUpdate: AnyPublisher<Routing,Never> {
        injected.appState.updates(for: \.routing.exercises)
    }
}

struct Exercises_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(category: Category.games)
    }
}
