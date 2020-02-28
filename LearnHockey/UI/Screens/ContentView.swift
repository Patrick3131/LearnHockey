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
    
    private let container: DIContainer
    init(container: DIContainer) {
        self.container = container
    }
    var body: some View {
        CategoriesListView().inject(container)
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
