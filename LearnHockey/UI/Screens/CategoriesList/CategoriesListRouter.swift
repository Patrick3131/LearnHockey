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
    class Router: ObservableObject, ExerciseRouting {
        @Published var categoriesRouting: CategoriesListView.Routing
        private var cancelBag = CancelBag()
        
        init(appState: Store<AppState>) {
            _categoriesRouting = .init(initialValue: appState.value.routing.categories)
            
            self.cancelBag.collect {
                $categoriesRouting
                    .removeDuplicates()
                    .sink { appState[\.routing.categories] = $0 }
                
                appState.map(\.routing.categories)
                    .removeDuplicates()
                    .assign(to: (\.categoriesRouting), on: self)
                
            }
        }
        
        func exerciseViewDestination(viewModel: CategoriesListView.ViewModel, category: Category) -> AnyView {
            return AnyView(
                NavigationLink(
                    destination: ExercisesView(viewModel:
                        viewModel.createExerciseViewModel(category: category)),
                    tag: category.name,
                    selection: Binding<String?>.init(get: {self.categoriesRouting.categories},
                                                     set: {  self.categoriesRouting.categories = $0 ?? ""}))
                {
                    CategorieCell(name: category.name, number: "\(category.numberOfExercises)")
            })
        }
    }
}
