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
        @Published var routingState: Routing = .init()
        @Published var categories: Loadable<[Category]>
        private let container: DIContainer
        private var cancelBag = CancelBag()
        
        init(container: DIContainer) {
            self.container = container
            _categories = .init(initialValue: Loadable<[Category]>.loaded([Category(name: "defense"),Category(name: "midfield"),Category(name: "offense"),Category(name: "games")]))
            
            let appState = container.appState
            _routingState = .init(initialValue: appState.value.routing.categories)
            self.cancelBag.collect {
                $routingState
                .removeDuplicates()
                    .sink { appState[\.routing.categories] = $0}
                appState.map(\.routing.categories)
                .print()
                .removeDuplicates()
                    .assign(to: (\.routingState), on: self)
            }
        }
        
        var title: String {
            "Categories"
        }
        
        func createExerciseViewModel(category: Category) -> ExercisesView.ViewModel {
            return .init(container: container, category: category)
        }
    }
    
    
}
