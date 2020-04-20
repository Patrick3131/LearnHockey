//
//  ContentViewViewModel.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 20.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

 
extension ContentView {
    class ViewModel: ObservableObject {
        private let container: DIContainer
        
        init(container: DIContainer) {
            self.container = container
        }
        
        func login() {
            container.interactors.authInteractor.loginState()
        }
        
        func createTabBarViewModel() -> TabBarView.ViewModel {
            .init(container: container)
        }
    }
}
