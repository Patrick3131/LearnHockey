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

protocol HasObjectWillChange {
    var objectWillChange: ObservableObjectPublisher { get }
}

protocol CategoriesListRouting:class,HasObjectWillChange {
    var exercisesRouting: CategoriesListView.Routing { get set }
    func exerciseViewDestination(viewModel: CategoriesListView.ViewModel, category: Category) -> AnyView
}

protocol ExercisesRouting:HasObjectWillChange {
    var exerciseDetailRouting: ExercisesView.Routing { get set }
    func exerciseDetailViewDestination(viewModel: ExercisesView.ViewModel,exercise: Exercise) -> AnyView
}

protocol AccountRouting: HasObjectWillChange {
    var routingState: AccountView.Routing { get set }
    var showLoginView: Bool { get set }
    var showManageSubscription: Bool { get set }
    
    func showLoginView(viewModel: AccountView.ViewModel) -> AnyView
    func showManageSubscription(viewModel: AccountView.ViewModel) -> AnyView
}
