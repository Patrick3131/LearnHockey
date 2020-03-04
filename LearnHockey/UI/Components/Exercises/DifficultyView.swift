//
//  DifficultyView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 29.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct DifficultyView: View {
    var difficulty: Int
    var title = "Difficulty"
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).font(.title)
            ThreeStarView(howManyStarsFilled: difficulty)
        }
    }
    
    
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyView(difficulty: 1)
    }
}
