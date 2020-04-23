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
        
        @Published private var accountDetails: Loadable<AppState.UserData.Account> = .notRequested {
            didSet {
                setRouting()
            }
        }
        @Published var router: AccountRouting

        private let container: DIContainer
        private var cancelBag = CancelBag()
        
        init(container: DIContainer) {
            self.container = container
            _router = .init(initialValue: Router(appState: container.appState))
            
            cancelBag.collect {
                router.objectWillChange
                    .sink {
                        self.objectWillChange.send()
                }
                authentificationUpdate
                    .assign(to: \.accountDetails, on: self)
            }
            
        }

        func loggingIn() {
            router.showLoginView = true
        }
        
        func manageSubscription() {
            router.showManageSubscription = true
        }
        
        func showManageSubscriptionView() -> AnyView {
            router.showManageSubscription(viewModel: self)
        }
        
        func showLoginView() ->  AnyView {
            router.showManageSubscription(viewModel: self)
        }
        
        func cancelLogin() {
            router.routingState = .notLoggedIn
        }
        
        func logOut() {
            container.interactors.authInteractor.logOut()
        }
        
        private func setRouting() {
            switch accountDetails {
            case .loaded(let user):
                if user.loggedIn {
                    router.routingState = .loggedIn
                }

                if user.loggedIn == false {
                    router.routingState = .notLoggedIn
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


