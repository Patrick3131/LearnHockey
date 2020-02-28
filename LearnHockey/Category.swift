//
//  Categories.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation


enum Category: String, CaseIterable {
    case defense = "Defense"
    case midfield = "Midfield"
    case offense = "Offense"
    
   
}

extension Category: Identifiable {
    var id: String { self.rawValue }
}

