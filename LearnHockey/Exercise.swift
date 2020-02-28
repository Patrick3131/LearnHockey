//
//  Exercise.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation

struct Exercise {
    /// id consists of Category + name
    let id: String
    let name: String
    let image: URL?
    let explanation: String?
    let duration: String?
    let amountOfPlayers: String?
    let coaching: String?
    let variation: String?
    let difficulty: Difficulty?
}

extension Exercise: Codable {}

extension Exercise {
    enum Difficulty: Int, Codable {
        case beginner
        case intermediate
        case advanced
    }
}
