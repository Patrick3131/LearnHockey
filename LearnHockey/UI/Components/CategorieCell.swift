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
    var body:some View {
        Text(name)
    }
}

struct CategorieCell_Previews: PreviewProvider {
    static var previews: some View {
        CategorieCell(name: "Categorie")
    }
}
