//
//  ExerciseCellViewModel.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI


extension ExerciseCell {
    struct ViewModel {
        let exerciseName: String
        let difficulty: Int
        let amountOfPlayers: String
        var colorText: Color = .baseDark
        var colorStars: Color = .baseLight
    }
}

extension ExerciseCell.ViewModel {
    init(exercise: Exercise){
        self.exerciseName = exercise.name ?? ""
        self.difficulty = exercise.difficulty?.rawValue ?? 0
        self.amountOfPlayers = exercise.amountOfPlayers ?? ""
        self.colorText = exercise.isPremium ? Color(.label) : Color.baseLight
        self.colorStars = exercise.isPremium ? Color.baseDark : Color.baseLight
    }
}
