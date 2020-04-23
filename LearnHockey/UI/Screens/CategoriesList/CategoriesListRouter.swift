//
//  CategoriesListRouter.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 23.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import SwiftUI

extension CategoriesListView {
    struct Routing: Equatable {
        var categories: String?
    }
}

extension CategoriesListView {
    class Router: ObservableObject, CategoriesListRouting {
        @Published var exercisesRouting: CategoriesListView.Routing
        private var cancelBag = CancelBag()
        
        init(appState: Store<AppState>) {
            _exercisesRouting = .init(initialValue: appState.value.routing.categories)
            
            self.cancelBag.collect {
                $exercisesRouting
                    .removeDuplicates()
                    .sink { appState[\.routing.categories] = $0 }
                
                appState.map(\.routing.categories)
                    .removeDuplicates()
                    .assign(to: (\.exercisesRouting), on: self)
            }
        }
        
        func exerciseViewDestination(viewModel: CategoriesListView.ViewModel, category: Category) -> AnyView {
            return AnyView(
                NavigationLink(
                    destination: ExercisesView(viewModel:
                        viewModel.createExerciseViewModel(category: category)),
                    tag: category.name,
                    selection: Binding<String?>.init(get: {self.exercisesRouting.categories},
                                                     set: {  self.exercisesRouting.categories = $0 ?? ""}))
                {
                    CategorieCell(name: category.name, number: "\(category.numberOfExercises)")
            })
        }
    }
}
