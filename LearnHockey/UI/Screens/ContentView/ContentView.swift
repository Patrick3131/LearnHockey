//
//  ContentView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        TabBarView(viewModel: viewModel.createTabBarViewModel())
            
            /// name check for Authentication would make more sense
            .onAppear() { self.viewModel.login() }
    }
}
