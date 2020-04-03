//
//  AuthInteractor.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 01.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import FirebaseAuth

protocol UserInteractor {
    func loginState()
    func logOut()
    func createPremium()
}

extension AccountDetails {
    init(accountDetails:AccountDetails, isPremiumUser: Bool) {
        self.name = accountDetails.name
        self.userUID = accountDetails.userUID
        self.loggedIn = accountDetails.loggedIn
        self.premiumUser = isPremiumUser
    }
}

struct AppUserInteractor: UserInteractor {
    
    
    let appState: Store<AppState>
    let authRepository: AuthRepository
    let premiumRepository: PremiumRepository
    let storage = CancelBag()

    
    
    init(authRepository: AuthRepository, appState: Store<AppState>, premiumRepository: PremiumRepository) {
        self.authRepository = authRepository
        self.appState = appState
           self.premiumRepository = premiumRepository
       }
    
    func createPremium() {
        let userID = appState[\.userData.accountDetails].value?.userUID
        let user = appState[\.userData.accountDetails].value
        let storage = CancelBag()
        /// causes memory leak has to be fixed
        premiumRepository.createPremium(user: userID ?? "1234", isPremium: true)
            .sink(receiveCompletion: { completion in
                print(completion.error?.localizedDescription as Any)
            }, receiveValue: { _ in
                print(user as Any, " : is a Premium User now")
            })
            .store(in: storage)
        
    }
    
    private func listenPremium(user: AccountDetails) {
        premiumRepository.listenPremium(user: user.userUID ?? "1234", completion: { value in
            value.map { value in
                return Loadable<AccountDetails>.loaded(AccountDetails(accountDetails: user, isPremiumUser: value))
            }
            .eraseToAnyPublisher()
            .sinkToLoadable { self.appState[\.userData.accountDetails] = $0.value! }
            .store(in: self.storage)
        })
    }
    
    
    func loginState() {
        let accountDetails = appState.value.userData.accountDetails.value
        appState[\.userData.accountDetails] = .isLoading(last: accountDetails, cancelBag: storage)
        
        let premium = authRepository.checkLoginState().flatMap { value -> AnyPublisher<Bool, Error> in
            self.listenPremium(user: value)
            return self.premiumRepository.readPremium(user: value.userUID)
        }
        
        authRepository.checkLoginState()
            .combineLatest(premium){ value, value2 in
                AccountDetails(accountDetails: value, isPremiumUser: value2)
        }
        .sinkToLoadable { self.appState[\.userData.accountDetails] = $0 }
        .store(in: storage)
    }
    
    func logOut() {
        
        authRepository.logOut()
    }
    
}

struct StubUserInteractor: UserInteractor {
    func createPremium() {
        
    }
    
    func logOut() {
        
    }
    
    func loginState() {
    
    }
    
    
}
