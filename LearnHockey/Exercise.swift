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
        return Exercise(name: "Big Game",
                        image: "https://firebasestorage.googleapis.com/v0/b/learnhockey1.appspot.com/o/exercise%2F2-2-2-zu-1-3-2-gegen-3-3-in-der-E-Jugend-1024x770.jpg?alt=media&token=db55ab67-1e89-419f-ac4f-a438b34a6324",
                        explanation: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic",
                        duration: "Half an hour",
                        amountOfPlayers: "Team",
                        coaching: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic",
                        variation: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic",
                        difficulty: .intermediate)
    }()
}
