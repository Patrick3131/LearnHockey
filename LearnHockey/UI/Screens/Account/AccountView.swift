//
//  AccountView2.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine

struct AccountView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    var body: some View {
        NavigationView {
            userContent
                .navigationBarTitle("Profil")
                .navigationBarItems(trailing: (
                    Group {
                        if viewModel.routingState == .loggedIn {
                            Button("Logout") {
                                self.viewModel.logOut()
                            }
                        } else {
                            EmptyView()
                        }
                    }
                ))
        }
    }
}

extension AccountView {
    private var userContent: AnyView {
        switch viewModel.routingState {
        case .notLoggedIn:
            return AnyView(NotLoggedInView(loginButtonClicked: {
                self.viewModel.loggingIn()
            }))
        case .loggedIn:
            return AnyView(ProfilView(viewModel: viewModel.createProfilViewModel()))
        case .loggingIn:
            return AnyView(LoginView(cancel: {
                self.viewModel.cancelLogin()
            }))
        }
    }
}

//
//struct AccountView2_Previews: PreviewProvider {
////    static var previews: some View {
////        AccountView2(viewModel: .init)
////    }
//}
