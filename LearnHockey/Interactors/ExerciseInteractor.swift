//
//  ExerciseInteractor.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

protocol ExerciseInteractor {
    func loadExercises(category: Category)
    func loadExercise(exerciseDetails: Binding<Loadable<Exercise>>, id: String)
}

struct AppExerciseInteractor:ExerciseInteractor {
    
    
    let appState: Store<AppState>
    
    func loadExercises(category: Category) {
        
    }
    
    func loadExercise(exerciseDetails: Binding<Loadable<Exercise>>, id: String) {
        
    }
    
}
