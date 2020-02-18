//
//  ExerciseInteractor.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

protocol ExerciseInteractor {
    func loadExercises(category: Category)
}

struct AppExerciseInteractor:ExerciseInteractor {
    let appState: Store<AppState>
    
    func loadExercises(category: Category) {
        
    }
    
}
