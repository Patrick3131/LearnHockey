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
    let category: Category
    
    @Environment(\.locale) private var locale: Locale
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var exercises: Loadable<[Exercise]>
    
    @State private var selection: Int = 1
    
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.exercises)
    }
    
    init(category:Category, exercises: Loadable<[Exercise]> = .notRequested) {
        self.category = category
        self._exercises = .init(initialValue: exercises)
    }
    
    var body: some View {
        content
            .navigationBarTitle(category.rawValue.capitalized)
            .fixNavigationBarBug { self.goBack() }
            .onReceive(routingUpdate) { self.routingState = $0 }
            .onReceive([self.selection].publisher.first()) { _ in
                self.filterExercises()
        }
    }
    
    private var content: AnyView {
        switch exercises {
        case .notRequested: return AnyView(notRequestedView)
        case let .isLoading(last, _): return AnyView(Text("loading"))
        case let .loaded(exercises) : return AnyView(loadedView(exercises))
        case let .failed(error): return AnyView(Text("failed"))
        }
    }
    private func filterExercises() {
        switch selection {
        case 0:
            let filtered = exercises.map { exercises in
                exercises.sorted { $0.name ?? "" > $1.name ?? "" }
            }
            exercises = filtered
        case 1:
            let filtered = exercises.map { exercises in
                exercises.sorted { $0.difficulty?.rawValue ?? 0 < $1.difficulty?.rawValue ?? 0 }
            }
            exercises = filtered
        case 2:
            let filtered = exercises.map { exercises in
                exercises.sorted { $0.amountOfPlayers ?? "" >  $1.amountOfPlayers ?? ""}
                
            }
            exercises = filtered
        default:
            break
            
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


private extension ExercisesView {
    func loadExercises() {
        injected.interactors.exerciseInteractor.loadExercises(exercises: $exercises, category: category)
    }
}

// MARK: - Loading Content

private extension ExercisesView {
    var notRequestedView: some View {
        Text("not requested").onAppear {
            self.loadExercises()
        }
    }
    
    func loadedView(_ exercises: [Exercise]) -> some View {
        VStack {
            Picker(selection: $selection, label: Text("df")) {
                Text("Name").tag(0)
                Text("Difficulty").tag(1)
                Text("Player").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
                .background(Color.baseLight)
                .padding([.top,.horizontal], 5)
            List(exercises) { exercise in
                NavigationLink(
                    destination: ExerciseDetailView(exercise: Exercise.mock),
                    tag: exercise.name!,
                    selection: self.routingBinding.exercise) {
                        ExerciseCell(exercise: exercise.name!, difficulty: exercise.difficulty!.rawValue , amountOfPlayers: exercise.amountOfPlayers!)
                }
                
            }
        }
            
    }
}

extension ExercisesView {
    struct Routing: Equatable {
        var exercise: String?
    }
    
    func goBack() {
        injected.appState[\.routing.categories.categories] = nil
    }
}

private extension ExercisesView {
    var routingUpdate: AnyPublisher<Routing,Never> {
        injected.appState.updates(for: \.routing.exercises)
    }
}

struct Exercises_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(category: Category.games)
    }
}
