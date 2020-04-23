//
//  AccountRouter.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 23.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import  SwiftUI
import Combine

extension AccountView {
    enum Routing: Equatable {
        case notLoggedIn
        case loggingIn
        case loggedIn
    }
}

extension AccountView {
    class Router: ObservableObject, AccountRouting {
        @Published var routingState: Routing
        @Published var showLoginView = false
        @Published var showManageSubscription = false
        
        private var cancelBag = CancelBag()
        
        init(appState: Store<AppState>) {
            _routingState = .init(initialValue: appState.value.routing.account)
            cancelBag.collect {
                [
                    $routingState
                    .removeDuplicates()
                        .sink { appState[\.routing.account] = $0}
                ]
            }
        
        }
        
        func showLoginView(viewModel: ViewModel) -> AnyView {
            return AnyView(EmptyView()
                .sheet(isPresented: Binding<Bool>.init(get: { self.showLoginView },
                                                       set: { self.showLoginView = $0 }), content: {
                                                        LoginView(cancel: {
                                                            viewModel.cancelLogin()
                                                        })
                }))
        }
        
        func showManageSubscription(viewModel: ViewModel) -> AnyView {
            return AnyView(EmptyView()
                .sheet(isPresented: Binding<Bool>.init(get: { self.showManageSubscription },
                                                       set: { self.showManageSubscription = $0 }), onDismiss: {
                }, content: {
                    BuySubscriptionView(viewModel: viewModel.createBuySubcriptionViewModel())
                })
            )
        }
    }

}
