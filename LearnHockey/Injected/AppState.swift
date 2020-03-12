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
        var account: Account = .notLoggedIn
        enum Account: Equatable {
            case notLoggedIn
            case loggingIn
            case loggedIn
        }
    }
}

typealias AccountRouting = AppState.ViewRouting.Account

extension AppState {
    struct UserData {
        var categories = Category.allCases
        var exercises: Loadable<[Exercise]> = .notRequested
        var exerciseDetail: Loadable<Exercise> = .notRequested
        var accountDetails: Loadable<AccountDetails> = .notRequested
        
        struct AccountDetails: Equatable {
            var userUID: String?
            var name: String?
            var loggedIn: Bool = false
            var premiumUser: Bool = false
        }
    }
}

typealias AccountDetails = AppState.UserData.AccountDetails
import FirebaseAuth
extension AccountDetails {
    init(_ user: User) {
        self.userUID = user.uid
        self.name = user.displayName
        self.loggedIn = true
    }
}

extension AppState {
    struct System {
        var isActive: Bool = false
    }
}
