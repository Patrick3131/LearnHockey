//
//  AccountViewModel.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine

extension AccountView {
    class ViewModel: ObservableObject {
        
        @Published var routingState: AccountRouting = .notLoggedIn
        @Published private var accountDetails: Loadable<AppState.UserData.Account> = .notRequested {
            didSet {
                print("324")
                setRouting()
            }
        }
        @Published var showLoginView = false
        @Published var showManageSubscription = false
        
        private let container: DIContainer
        private var cancelBag = CancelBag()
        
        init(container: DIContainer) {
            self.container = container
            let appState = container.appState
            cancelBag.collect {
                $routingState
                    .removeDuplicates()
                    /// actually it would be enough if the state is only stored in this ViewModel, I will remove the Routing state out of the Appstate
                    .sink { appState[\.routing.account] = $0 }
                authentificationUpdate
                    .assign(to: \.accountDetails, on: self)
            }
            
        }

        
        func loggingIn() {
            showLoginView = true
        }
        
        func manageSubscription() {
            showManageSubscription = true
        }
        
        func cancelLogin() {
            routingState = .notLoggedIn
        }
        
        func logOut() {
            container.interactors.authInteractor.logOut()
        }
        
        private func setRouting() {
            switch accountDetails {
            case .loaded(let user):
                if user.loggedIn {
                    routingState = .loggedIn
                }

                if user.loggedIn == false {
                    routingState = .notLoggedIn
                }
            default: break
            }
        }
        
        private var authentificationUpdate: AnyPublisher<Loadable<AppState.UserData.Account>,Never> {
            container.appState.updates(for:\.userData.accountDetails)
        }
    }
}

extension AccountView.ViewModel {
    // MARK: - ProfilView
    func createProfilViewModel() -> ProfilView.ViewModel {
        return ProfilView.ViewModel(
            profilOverviewViewModel: createProfilOverviewViewModel(),
            sendFeedback: { [weak self] in
                if let safeSelf = self {
                    safeSelf.sendFeedback()
                }
            },
            deleteProfil: { [weak self] in
                if let safeSelf = self {
                    safeSelf.deleteProfil()
                }
        })
    }
    
    func createProfilOverviewViewModel() -> ProfilOverviewView.ViewModel {
        ProfilOverviewView.ViewModel(name: accountDetails.value?.name ?? "", subscription: .validSubscription(period: .monthly, cost: "3€", valid: .renew("15. Mai")), manage: { [weak self] in
            if let safeSelf = self {
                safeSelf.manageSubscription()
            }
        })
    }
    
    func sendFeedback() {
        print("Ist noch nicht implementiert")
    }
    
    func deleteProfil() {
        print("Ist noch nicht implementiert")
    }
    
    // MARK: - BuySubscription
    func createBuySubcriptionViewModel() -> BuySubscriptionView.ViewModel {
        BuySubscriptionView.ViewModel(container: container)
    }
}


