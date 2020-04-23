//
//  CategoriesListViewmodel.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 19.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

extension CategoriesListView {
    class ViewModel: ObservableObject {
        @Environment(\.locale) private var locale: Locale
        @Published var categories: Loadable<[Category]>
        @Published var routing: ExerciseRouting
        private let container: DIContainer
        private var cancelBag = CancelBag()
        
        init(container: DIContainer) {
            self.container = container
            _categories = .init(initialValue: Loadable<[Category]>.loaded([Category(name: "defense"),Category(name: "midfield"),Category(name: "offense"),Category(name: "games")]))
            
            let appState = container.appState
            _routing = .init(initialValue: Router(appState: appState))
            
            cancelBag.collect {
                [
                    routing.objectWillChange
                        .sink {
                            self.objectWillChange.send()
                    }
                ]
            }
        }
        
        var title: String {
            "Categories"
        }
        
        func routingToExercisesView(category: Category) -> AnyView {
            return routing.exerciseViewDestination(viewModel: self, category: category)
        }
        
        func createExerciseViewModel(category: Category) -> ExercisesView.ViewModel {
            return .init(container: container, category: category)
        }
    }
    
    
}
