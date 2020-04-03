//
//  ExerciseCell.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 29.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI




struct ExerciseCell: View {
    let viewModel: ExerciseCellViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.exerciseName).foregroundColor(viewModel.colorText)
                ThreeStarView(howManyStarsFilled: viewModel.difficulty,foreGroundColor: viewModel.colorStars)
            }
            Spacer()
            Text(viewModel.amountOfPlayers).foregroundColor(viewModel.colorText)
        }.padding()
        
        
    }
}

struct ExerciseCell_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCell(viewModel: ExerciseCellViewModel(exercise: Exercise.mock))
    }
}
