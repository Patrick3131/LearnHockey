//
//  AppEnvironment.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let interactors = configureInteractors(appState: appState)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        let systemEventsHandler = AppSystemEventsHandler(appState)
        return AppEnvironment(container: diContainer, systemEventsHandler: systemEventsHandler)
    }
    
    private static func configureInteractors(appState: Store<AppState>) -> DIContainer.Interactors {
        return .init()
    }
}
