//
//  CategoriesList.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine

struct CategoriesListView: View {
    @Environment(\.locale) private var locale: Locale
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        content
    }
  
    private var content: some View {
        NavigationView {
            loadedView
            .navigationBarTitle(viewModel.title)
        }
    }
    
    private var loadedView: AnyView {
        switch viewModel.categories {
        case .loaded(let categories):
            return AnyView(List(categories) { category in
                NavigationLink(
                    destination: ExercisesView(viewModel: self.viewModel.createExerciseViewModel(category:category)),
                    tag: category.name,
                    selection: self.$viewModel.routingState.categories) {
                        CategorieCell(name: category.name, number: "\(category.numberOfExercises)")
                }
            })
        default:
            return AnyView(EmptyView())
        }
    }
}

extension CategoriesListView {
    struct Routing: Equatable {
        var categories: String?
    }
}


struct CategoriesList_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView(viewModel: CategoriesListView.ViewModel(container: DIContainer.defaultValue))
    }
}
