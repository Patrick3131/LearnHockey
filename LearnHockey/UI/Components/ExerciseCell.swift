//
//  ExerciseCell.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 29.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct ExerciseCell: View {
    let exercise: String
    let difficulty: Int
    let amountOfPlayers: String
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(exercise)
                ThreeStarView(howManyStarsFilled: difficulty)
            }
            Spacer()
            Text(amountOfPlayers)
        }.padding()
        
        
    }
}

struct ExerciseCell_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseCell(exercise: "Ball hochhalten", difficulty: 2, amountOfPlayers: "Team")
    }
}
