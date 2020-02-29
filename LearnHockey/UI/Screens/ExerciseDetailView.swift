//
//  ExerciseView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 28.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    
    @Environment(\.locale) private var locale: Locale
    @Environment(\.injected) private var injected: DIContainer
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    self.createImageItem(title: "Image", image: self.exercise.image)
                    self.createDifficultyItem(title: "Difficulty", content: self.exercise.difficulty)
                    self.createItem(title: "Amount of Players", content: self.exercise.amountOfPlayers)
                    self.createItem(title: "Explanation", content: self.exercise.variation)
                    self.createItem(title: "Duration", content: self.exercise.variation)
                    self.createItem(title: "Coaching", content: self.exercise.variation)
                    self.createItem(title: "Variation", content: self.exercise.coaching)
                    
                }.padding()
                    .navigationBarTitle(self.exercise.name ?? "")
            }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
        }
        
        
    }
    
    func createItem(title: String, content: String?) -> AnyView {
        AnyView(
            Group {
            if content != nil {
                DetailItemView(title: title, content: content!)
            } else {
                EmptyView()
            }
        })
    }
    
    func createDifficultyItem(title: String, content: Exercise.Difficulty?) -> AnyView {
        AnyView(
            Group {
                if content != nil {
                    DifficultyView(difficulty: content!.rawValue)
                } else {
                    EmptyView()
                }
            }
        )
        
    }
    
    func createImageItem(title: String, image: String?) -> AnyView {
        AnyView(
            Group {
                if image != nil && URL(string: image ?? "") != nil {
                    CachedImage(URL(string: image!)!)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                } else {
                    EmptyView()
                }
            }
        )
    }
}


struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailView(exercise: Exercise.mock)
    }
}
