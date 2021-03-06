//
//  ThreeStarView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 29.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct ThreeStarView: View {
    var howManyStarsFilled: Int
    var foreGroundColor: Color = Color(.label)
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "star.fill").foregroundColor(foreGroundColor)
            Image(systemName: self.secondStar()).foregroundColor(foreGroundColor)
            Image(systemName: self.thirdStar()).foregroundColor(foreGroundColor)
        }
    }
    
    private func secondStar() -> String {
        if howManyStarsFilled > 1 {
            return "star.fill"
        } else {
           return "star"
        }
    }
    
    private func thirdStar() -> String {
        if howManyStarsFilled > 2 {
            return "star.fill"
        } else {
           return "star"
        }
    }
}

struct ThreeStarView_Previews: PreviewProvider {
    static var previews: some View {
        ThreeStarView(howManyStarsFilled: 1, foreGroundColor: Color.baseMidDark)
    }
}
