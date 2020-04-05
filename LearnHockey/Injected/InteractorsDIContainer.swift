//
//  InteractorsDIContainer.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//


extension DIContainer {
    struct Interactors {
        let exerciseInteractor: ExerciseInteractor
        let authInteractor: AccountInteractor
        
        init(exerciseInteractor: ExerciseInteractor,
             authInteractor: AccountInteractor
        ) {
            self.exerciseInteractor = exerciseInteractor
            self.authInteractor = authInteractor
        }
        
        
        static var stub: Self {
            .init(exerciseInteractor: StubAppExerciseInteractor(),
                  authInteractor: StubUserInteractor()
            )
        }
    }
    
    
}
