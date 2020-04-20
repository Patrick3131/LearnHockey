//
//  ExerciseDetailViewModel.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 20.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


extension ExerciseDetailView {
    struct ViewModel {
        private let exercise: Exercise
        private let container: DIContainer
        
        init(container: DIContainer, exercise: Exercise) {
            self.container = container
            self.exercise = Exercise.mock
        }
        
        var image: String? {
            exercise.image
        }
        
        var difficulty: Exercise.Difficulty? {
            exercise.difficulty
        }
        
        var amountOfPlayers: String? {
            exercise.amountOfPlayers
        }
        
        var explanation: String? {
            exercise.variation
        }
        
        var duration: String? {
            exercise.variation
        }
        
        var coaching: String? {
            exercise.coaching
        }
        
        var variation: String? {
            exercise.variation
        }
        
        var navigationBarTitle: String {
            exercise.name ?? "Exercise"
        }
        
    }
}
