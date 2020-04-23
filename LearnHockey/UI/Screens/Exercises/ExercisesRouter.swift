//
//  ExercisesRouter.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 23.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import SwiftUI


extension ExercisesView {
    struct Routing: Equatable {
        var exercise: String?
    }
}

extension ExercisesView {
    class Router:ObservableObject, ExercisesRouting {
        @Published var exerciseDetailRouting: ExercisesView.Routing
        private var cancelBag = CancelBag()
        
        init(appState: Store<AppState>) {
            _exerciseDetailRouting = .init(initialValue: appState.value.routing.exercises)
            
            self.cancelBag.collect {
                $exerciseDetailRouting
                    .removeDuplicates()
                    .sink { appState[\.routing.exercises] = $0 }
                
                appState.map(\.routing.exercises)
                    .removeDuplicates()
                    .assign(to: (\.exerciseDetailRouting), on: self)
            }
        }
        
        
        func exerciseDetailViewDestination(viewModel: ExercisesView.ViewModel,exercise: Exercise) -> AnyView{
            return AnyView(
                NavigationLink(
                    destination: ExerciseDetailView(viewModel: viewModel.createExerciseDetailViewModel(exercise: exercise)),
                    tag: exercise.name!,
                    selection: Binding<String?>.init(get: {self.exerciseDetailRouting.exercise },
                                                     set: { self.exerciseDetailRouting.exercise = $0 ?? ""}))
                {
                    ExerciseCell(viewModel: viewModel.createExerciseCellViewModel(exercise: exercise))
                }
            )
        }
        
    }
}
