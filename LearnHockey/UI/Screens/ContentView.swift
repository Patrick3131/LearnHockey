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
    @State private var accountDetails: Loadable<AppState.UserData.AccountDetails> = .notRequested
    init(container: DIContainer) {
        self.container = container
    }
    var body: some View {
        Group {
            CategoriesListView().inject(container)
        }.onAppear() { self.container.interactors.authInteractor.checkLoginState(accountDetails: self.$accountDetails) }
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
