//
//  AppSystemEventsHandler.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation

struct AppSystemEventsHandler: SystemEventsHandler {

    
    let appState: Store<AppState>
    
    init(_ appState: Store<AppState>) {
        self.appState = appState
    }
    
    
    func sceneDidBecomeActive() {
        appState[\.system.isActive] = true
    }
    
    func sceneWillResignActive() {
        appState[\.system.isActive] = false
    }
}
