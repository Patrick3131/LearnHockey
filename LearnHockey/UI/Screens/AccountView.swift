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
            return AnyView(AccountLoggedIn(userName: "Patrick Fischer", logOut: {
                self.injected.interactors.authInteractor.logOut()
            }))
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
    
    var authentificationUpdate: AnyPublisher<Loadable<AppState.UserData.AccountDetails>,Never> {
        injected.appState.updates(for:\.userData.accountDetails)
    }
    var routingUpdate:AnyPublisher<AccountRouting,Never> {
        injected.appState.updates(for: \.routing.account)
    }
}

struct AccountLoggedIn: View {
    var userName: String
    var logOut: () -> Void
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Hello " + self.userName + "!" ).font(.title)
                Text("You currently have a monthly membership for 10$ a month.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer().frame(height: geometry.size.height * 0.1)
                LogInOutButton(action: {
                    self.logOut()
                }, title: "Log out", width: geometry.size.width * 0.7)
            }
            
        }
        
    }
}

struct LogInOutButton: View {
    var action: () -> Void
    var title: String
    var width: CGFloat?

    var body: some View {
        Button(action: {
            print(self.title)
            self.action()
        }, label: {
            Text(title).font(.title)
            })
            .frame(width: self.width)
        .padding()
            .background(Color.white)
        .cornerRadius(5)
        .padding(1)
            .background(Color.black)
        .cornerRadius(5)
    }
}

struct AccountNotLoggedIn: View {
    
    var loginButtonClicked: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("You are currently not logged in. Do you want to log in or create a new account?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, geometry.size.width * 0.2)
                Spacer().frame(height: geometry.size.height * 0.25)
                LogInOutButton(action: {
                    self.loginButtonClicked()
                }, title: "Yes!", width: geometry.size.width * 0.7)
            }
        }
        
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountLoggedIn(userName: "Patrick Fischer", logOut: {

        })
//        AccountNotLoggedIn(loginButtonClicked: {
//
//        })
    }
}
