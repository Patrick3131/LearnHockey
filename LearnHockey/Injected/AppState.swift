//
//  AppState.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation


struct AppState {
    var categories = UserData()
    var system = System()
}


extension AppState {
    struct UserData {
        var categories = Category.allCases
    }
}

extension AppState {
    struct System {
        var isActive: Bool = false
    }
}