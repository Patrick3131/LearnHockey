//
//  Categories.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation


enum Category: String, CaseIterable {
    case defense = "defense"
    case midfield = "midfield"
    case offense = "offense"
    case games = "games"
}



extension Category: Identifiable {
    var id: String { self.rawValue }
}

