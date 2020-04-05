//
//  AppEnvironment.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import UIKit
import Combine
import Firebase
import FirebaseFirestore

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
        
        FirebaseApp.configure()
        
        let exerciseWebRepository = FirebaseWebRepository(store: Firestore.firestore())
        let exerciseInteractor = AppExerciseInteractor(webRepository: exerciseWebRepository, appState: appState)
        
        let authRepository = FirebaseAuthRepository()
        let premiumRepository = FirebasePremiumRepository()
        let authInteractor = AppAccountInteractor(authRepository: authRepository, appState: appState, premiumRepository: premiumRepository)
        return .init(exerciseInteractor: exerciseInteractor, authInteractor: authInteractor)
    }
}
