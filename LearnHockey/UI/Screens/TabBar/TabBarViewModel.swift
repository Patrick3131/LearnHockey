//
//  TabBarViewModel.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 20.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


extension TabBarView {
    class ViewModel:ObservableObject {
        @Published var selectedTab = Tab.exercise
        private let container:DIContainer
        
        init(container:DIContainer) {
            self.container = container
        }
        
        func createCategoriesListViewModel() -> CategoriesListView.ViewModel {
            return .init(container: container)
        }
        
        func createAccountViewModel() -> AccountView.ViewModel {
            return .init(container: container)
        }
        
    }
}
