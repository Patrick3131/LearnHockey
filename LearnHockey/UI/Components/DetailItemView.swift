//
//  DetailItemView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 28.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct DetailItemView: View {
    var title: String
    var content: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.title)
            Text(content)
        }
    }
}

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        DetailItemView(title: "Spieleranzahl", content: "Einzel/Partnerrrrefkleaflkenrf eaksfijerkaushferasf kjehfkersfaksjfksdfers feuhfiaehfsierkshdf jkhsafdiasfkasdjfasedfkeshadfkshdfjsaf")
    }
}
