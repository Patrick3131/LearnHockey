//
//  AccountView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine

struct AccountView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var accountDetails: Loadable<AppState.UserData.AccountDetails> = .notRequested
    @State private var routingState = AccountRouting.notLoggedIn
    
    var body: some View {
        NavigationView {
            userContent
                .navigationBarTitle("Account")
        }
        .onReceive(authentificationUpdate) { value in
            print(value)
            self.accountDetails = value
            self.setRouting()
            
        }
        .onReceive(routingUpdate) { value in
            print(value)
            self.routingState = value
            
        }
    }
    
    
    private func setRouting() {
        switch accountDetails {
        case .loaded(let user):
            if user.loggedIn {
                injected.appState[\.routing.account] = .loggedIn
            }
            if user.loggedIn == false && (routingState != .loggingIn) {
                injected.appState[\.routing.account] = .notLoggedIn
            }
        default: break
        }
    }
    
    private var userContent: AnyView {
        switch routingState {
        case .loggedIn:
            return AnyView(
                AccountLoggedIn(
                    userName: accountDetails.value?.name ?? "User",
                    logOut: {
                        self.injected.interactors.authInteractor.logOut()},
                    buyPremium: {
                        self.createPremium()
                },
                    isPremium: accountDetails.value?.premiumUser ?? false)
            )
        case .notLoggedIn:
            return
                AnyView(AccountNotLoggedIn(loginButtonClicked: {
                    self.injected.appState[\.routing.account] = .loggingIn
                }))
        case .loggingIn:
            return AnyView(LoginView() {
                self.injected.appState[\.routing.account] = .notLoggedIn
            }
            .navigationBarHidden(true)
            )
        }
    }
    
    private func createPremium() {
        injected.interactors.authInteractor.createPremium()
    }
    
    private var authentificationUpdate: AnyPublisher<Loadable<AppState.UserData.AccountDetails>,Never> {
        injected.appState.updates(for:\.userData.accountDetails)
    }
    private var routingUpdate:AnyPublisher<AccountRouting,Never> {
        injected.appState.updates(for: \.routing.account)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
