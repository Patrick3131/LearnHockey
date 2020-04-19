//
//  CategoriesListViewmodel.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 19.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

extension CategoriesListView {
    class ViewModel: ObservableObject {
        @Environment(\.locale) private var locale: Locale
        @Published var routingState: Routing = .init()
        @Published var categories: Loadable<[Category]>
        private let container: DIContainer
        private var cancelBag = CancelBag()
        
        init(container: DIContainer) {
            self.container = container
            
            self.categories = Loadable<[Category]>.loaded([Category(name: "Defense"),Category(name: "Midfield"),Category(name: "Offense"),Category(name: "Games")])
            
            let appState = container.appState
            self.cancelBag.collect {
                $routingState
                    .sink { appState[\.routing.categories] = $0}
                appState.map(\.routing.categories)
                .removeDuplicates()
                    .assign(to: (\.routingState), on: self)
            }
        }
        
        var title: String {
            "Categories"
        }
    }
}
