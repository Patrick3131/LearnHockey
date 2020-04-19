//
//  Categories.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation


struct Category {
    let name: String
    var numberOfExercises = 4
}



extension Category: Identifiable {
    var id: String { self.name }
}

