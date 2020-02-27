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
        print(routingState)
        return $routingState.dispatched(to: injected.appState, \.routing.categories)
    }
    private var categories = Category.allCases
    var body: some View {
        content
            .onReceive(routingUpdate) { value in
                print(value)
                self.routingState = value
        }
    }
    
    
    private var content: some View {
        NavigationView {
            List(self.categories) { category in
                NavigationLink(
                    destination: Exercises(),
                    tag: category.rawValue,
                    selection: self.routingBinding.categories) {
                        CategorieCell(name: category.rawValue)
                }
            }.navigationBarTitle("Categories")
        }
        
        
    }
}

// MARK: - State Updates

private extension CategoriesList {
    var routingUpdate: AnyPublisher<Routing, Never> {
        injected.appState.updates(for: \.routing.categories)
    }
}

extension CategoriesList {
    struct Routing: Equatable {
        var categories: String?
    }
}



struct ExerciseDetail: View {
    var body: some View {
        Text("Hello DetailsView")
    }
}



struct CategoriesList_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesList()
    }
}
