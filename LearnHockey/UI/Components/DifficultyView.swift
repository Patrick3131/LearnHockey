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
            HStack(spacing: 5) {
                Image(systemName: "star.fill")
                Image(systemName: self.secondStar())
                Image(systemName: self.thirdStar())
            }
        }
    }
    
    private func secondStar() -> String {
        if difficulty > 1 {
            return "star.fill"
        } else {
           return "star"
        }
    }
    
    private func thirdStar() -> String {
        if difficulty > 2 {
            return "star.fill"
        } else {
           return "star"
        }
    }
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyView(difficulty: 1)
    }
}
