//
//  CategorieCell.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 27.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct CategorieCell: View {
    var name: String
    var number: String
    var body:some View {
        HStack {
            Text(number)
                .frame(width: 40)
                .background(Color(.systemBackground))
                .cornerRadius(5)
                .padding(1)
                    .background(Color.baseMidDark)
                .cornerRadius(5)
            Spacer().frame(width: 60)
            Text(name.capitalized)
        }
    }
}

struct CategorieCell_Previews: PreviewProvider {
    static var previews: some View {
        CategorieCell(name: "Categorie", number: "2")
    }
}
