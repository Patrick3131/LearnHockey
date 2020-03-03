//
//  ExercisesWebRepository.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 28.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import Combine


protocol ExercisesWebRepository {
    func loadExercises(category: Category) -> AnyPublisher<[Exercise],Error>
    func loadExerciseDetail(_ exerciseId : String) -> AnyPublisher<Exercise,Error>
}

