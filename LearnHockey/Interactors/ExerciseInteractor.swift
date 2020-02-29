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
    func loadExercises(exercises: Binding<Loadable<[Exercise]>>,category: Category)
    func loadExerciseDetail(exerciseDetails: Binding<Loadable<Exercise>>, categorie: Category, id: String)
}

struct AppExerciseInteractor:ExerciseInteractor {

    
    
    let webRepository: ExercisesWebRepository
    let appState: Store<AppState>
    
    func loadExercises(exercises: Binding<Loadable<[Exercise]>>, category: Category) {
        let cancelBag = CancelBag()
        exercises.wrappedValue = .isLoading(last: exercises.wrappedValue.value, cancelBag: cancelBag)
        
        webRepository.loadExercises(category: category)
            .map { $0.filter { $0.name != nil}}
            .sinkToLoadable { exercises.wrappedValue = $0 }
            .store(in: cancelBag)
    }
    
    func loadExerciseDetail(exerciseDetails: Binding<Loadable<Exercise>>, categorie: Category, id: String) {
        
    }
    
}

struct StubAppExerciseInteractor: ExerciseInteractor {
    func loadExercises(exercises: Binding<Loadable<[Exercise]>>, category: Category) {
        
    }
    
   
    func loadExerciseDetail(exerciseDetails: Binding<Loadable<Exercise>>, categorie: Category, id: String) {
        
    }
    
    
}
