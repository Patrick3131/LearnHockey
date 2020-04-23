//
//  Exercises.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 18.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine

struct ExercisesView: View {
    
    @Environment(\.locale) private var locale: Locale
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .navigationBarTitle(viewModel.category.name.capitalized)
            .fixNavigationBarBug { self.viewModel.goBack() }
    }
    
    private var content: AnyView {
        switch viewModel.exercises {
        case .notRequested: return AnyView(notRequestedView)
        case .isLoading(_, _): return AnyView(Text("loading"))
        case let .loaded(exercises) : return AnyView(loadedView(exercises))
        case .failed(_): return AnyView(Text("failed"))
        }
    }
}

private extension ExercisesView {
    struct ExercisesFilter {
        
        var seletcion: Int {
            didSet { }
        }
        
        
    }
}

// MARK: - Loading Content

private extension ExercisesView {
    var notRequestedView: some View {
        Text("not requested").onAppear {
            self.viewModel.loadExercises()
        }
    }
    
    func loadedView(_ exercises: [Exercise]) -> some View {
        VStack {
            Picker(selection: $viewModel.selection, label: Text("df")) {
                Text("Name").tag(0)
                Text("Difficulty").tag(1)
                Text("Player").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
                .background(Color.baseLight)
                .padding([.top,.horizontal], 5)
            List(exercises) { exercise in
                self.viewModel.routingToExerciseDetailView(exercise: exercise)
            }
        }
            
    }
}




//struct Exercises_Previews: PreviewProvider {
//    static var previews: some View {
//        ExercisesView(category: Category(name: "games"))
//    }
//}
