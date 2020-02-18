//
//  CategoriesList.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine

struct CategoriesList: View {
    @Environment(\.locale) private var locale: Locale
    @Environment(\.injected) private var injected: DIContainer
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.exercises)
    }
    private var categories = Category.allCases
    var body: some View {
        content
    }
    
    
    private var content: some View {
        List(self.categories) { category in
            NavigationLink(
                destination: Exercises(),
                tag: category.rawValue,
                selection: self.routingBinding.exercises) {
                    CategorieCell()
                }
        }

    }
}

extension CategoriesList {
    struct Routing: Equatable {
        var exercises: String?
    }
}

struct Exercises: View {
    var body: some View {
        Text("")
    }
}

struct ExerciseDetail: View {
    var body: some View {
        Text("Hello DetailsView")
    }
}

struct CategorieCell: View {
    var body:some View {
        Text("Test")
    }
}

struct CategoriesList_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesList()
    }
}
