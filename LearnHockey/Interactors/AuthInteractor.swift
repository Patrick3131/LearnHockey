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

protocol AuthInteractor {
    func loginState()
    func logOut()
}

struct AppAuthInteractor: AuthInteractor {
    
    
    let authRepository: AuthRepository
    let appState: Store<AppState>

    init(authRepository: AuthRepository, appState: Store<AppState>) {
        self.authRepository = authRepository
        self.appState = appState
    }
    
    func loginState() {
        let cancelBag = CancelBag()
        let accountDetails = appState.value.userData.accountDetails.value
        appState[\.userData.accountDetails] = .isLoading(last: accountDetails, cancelBag: cancelBag)
        
//        weak var weakAppState = appState
        
        authRepository.checkLoginState() { value in
            value.sinkToLoadable { self.appState[\.userData.accountDetails] = $0 }
                .store(in: cancelBag)
            
        }
    }
    
    func logOut() {
        
        authRepository.logOut()
    }
    
}

struct StubAuthInteractor: AuthInteractor {
    func logOut() {
        
    }
    
    func loginState() {
    
    }
    
    
}
