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
            content
                .onReceive(authentificationUpdate) { value in
                    print("onRecieve:", value)
                    self.accountDetails = value
                    
            }
        .onAppear() { self.container.interactors.authInteractor.checkLoginState() }
    }
    
    
    private var content: AnyView {
        print("container: ",container.appState.value.userData.accountDetails)
        switch accountDetails {
            
        case .loaded(let details):
            
            if details.loggedIn == true {
                return AnyView(CategoriesListView().inject(container))
            } else {
                return AnyView(LoginView())
            }
        case .notRequested:
            return AnyView(LoginView())
        default: break
        }
        return AnyView(EmptyView())
    }
}

 extension ContentView {
    var authentificationUpdate: AnyPublisher<Loadable<AppState.UserData.AccountDetails>,Never> {
        container.appState.updates(for:\.userData.accountDetails)
    }
}
