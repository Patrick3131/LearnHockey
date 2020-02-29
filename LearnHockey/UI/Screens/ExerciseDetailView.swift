//
//  ExerciseView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 28.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    
    @Environment(\.locale) private var locale: Locale
    @Environment(\.injected) private var injected: DIContainer
    
    
    var body: some View {
        Group {
            
            if exercise.amountOfPlayers != nil {
                DetailItemView(title: "Amount of players", content: exercise.amountOfPlayers!)
            } else {
                EmptyView()
            }
//            if exercise.coaching != nil {
//                DetailItemView(title: "Coaching", content: exercise.coaching!)
//            }
        }
    }
}


struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailView(exercise: Exercise.mock)
    }
}
