//
//  Exercise.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation

struct Exercise {
    
    var name: String?
    var image: String?
    var explanation: String?
    var duration: String?
    var amountOfPlayers: String?
    var coaching: String?
    var variation: String?
    var difficulty: Difficulty?
    
}

extension Exercise: Codable {}
extension Exercise: Equatable {}

extension Exercise: Identifiable {
    var id: String {
        return name ?? UUID().uuidString
    }
}

extension Exercise {
    enum Difficulty: Int, Codable {
        case beginner
        case intermediate
        case advanced
    }
}

extension Exercise {
    static var mock: Exercise = {
      return Exercise(name: "Präzises Werfen", image: nil, explanation: nil, duration: nil, amountOfPlayers: nil, coaching: nil, variation: nil, difficulty: nil)
    }()
}
