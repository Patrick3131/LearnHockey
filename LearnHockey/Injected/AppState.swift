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
        var account = AccountView.Routing.notLoggedIn
    
    }
}

extension AppState {
    struct UserData {
        var categories = [Category(name: "Defense"),Category(name: "Midfield"),Category(name: "Offense"),Category(name: "Games")]
        var exercises: Loadable<[Exercise]> = .notRequested
        var exerciseDetail: Loadable<Exercise> = .notRequested
        var accountDetails: Loadable<Account> = .notRequested
        
        struct Account: Equatable {
            var userUID: String?
            var name: String?
            var loggedIn: Bool = false
            var details: Details?
        }
    }
}

typealias Account = AppState.UserData.Account
import FirebaseAuth
extension Account {
    init(_ user: User) {
        self.userUID = user.uid
        self.name = user.displayName
        self.loggedIn = true
    }
}

extension Account {
    struct Details: Codable, Equatable {
        var premium: Bool = false
        
    }
}

extension AppState {
    struct System {
        var isActive: Bool = false
    }
}
