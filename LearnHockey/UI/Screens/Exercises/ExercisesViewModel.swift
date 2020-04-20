//
//  ExercisesViewModel.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 19.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

extension ExercisesView {
    class ViewModel: ObservableObject {
        @Published var exercises: Loadable<[Exercise]>
        @Published var selection: Int = 0
        @Published var routingState: Routing = .init()

        private let container: DIContainer
        private var cancelBag = CancelBag()
        let category: Category
        
        init(container: DIContainer,category: Category) {
            self.container = container
            self.category = category
            _exercises = .init(initialValue: .notRequested)
            let appState = container.appState
            _routingState = .init(initialValue: appState.value.routing.exercises)
            cancelBag.collect {
                    self.routingUpdate
                    .removeDuplicates()
                        .assign(to: \.routingState, on: self)
                    $selection
                    .sink(receiveValue: { _ in
                        self.filterExercises()
                    })
            }
        }
        
        func loadExercises() {
            container.interactors.exerciseInteractor.loadExercises(exercises: Binding<Loadable<[Exercise]>>.init(get: { [weak self] in
                (self?.exercises ?? Loadable<[Exercise]>.notRequested)
//                self?[keyPath: \.exercises] ?? self![keyPath: \.exercises]
            }, set: { [weak self] in
                self?.exercises = $0
//                self?[keyPath: \.exercises] = $0
            }), category:category)
        }
        
        
        var routingUpdate: AnyPublisher<Routing,Never> {
            container.appState.updates(for: \.routing.exercises)
        }
        
        /// shouldnt know about its parent or that its nested in to CategoriesView Navigation but currently there is a bug.
        func goBack() {
            container.appState[\.routing.categories.categories] = nil
        }
        
        func filterExercises() {
            switch selection {
            case 0:
                let filtered = exercises.map { exercises in
                    exercises.sorted { $0.name ?? "" > $1.name ?? "" }
                }
                exercises = filtered
            case 1:
                let filtered = exercises.map { exercises in
                    exercises.sorted { $0.difficulty?.rawValue ?? 0 < $1.difficulty?.rawValue ?? 0 }
                }
                exercises = filtered
            case 2:
                let filtered = exercises.map { exercises in
                    exercises.sorted { $0.amountOfPlayers ?? "" >  $1.amountOfPlayers ?? ""}
                }
                exercises = filtered
            default:
                break
                
            }
        }
    }
}


extension ExercisesView.ViewModel {
    func createExerciseCellViewModel(exercise: Exercise) -> ExerciseCell.ViewModel {
        return ExerciseCell.ViewModel(exercise: exercise)
    }
    
    func createExerciseDetailViewModel(exercise: Exercise) -> ExerciseDetailView.ViewModel {
        return ExerciseDetailView.ViewModel(container: container, exercise: exercise)
    }
 
}
