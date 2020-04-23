//
//  CategoriesCoordinator.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 23.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

protocol ExerciseRouting {
    var categoriesRouting: CategoriesListView.Routing { get set }
    func exerciseViewDestination(viewModel: CategoriesListView.ViewModel, category: Category) -> AnyView
}


protocol ExerciseDetailRouting {
    var exerciseDetailRouting: ExercisesView.Routing { get set }
    func exerciseDetailViewDestination(viewModel: ExercisesView.ViewModel,exercise: Exercise) -> AnyView
}



