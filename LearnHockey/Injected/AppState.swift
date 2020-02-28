//
//  AppState.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation


struct AppState {
    var userData = UserData()
    var system = System()
    var routing = ViewRouting()
}

extension AppState {
    struct ViewRouting:Equatable {
        var categories = CategoriesListView.Routing()
        var exercises = ExercisesView.Routing()
    }
}

extension AppState {
    struct UserData {
        var categories = Category.allCases
        var exercises: Loadable<[Exercise]> = .notRequested
        var exerciseDetail: Loadable<Exercise> = .notRequested
    }
}

extension AppState {
    struct System {
        var isActive: Bool = false
    }
}
