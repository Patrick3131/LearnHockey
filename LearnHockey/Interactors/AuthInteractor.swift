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

protocol AuthInteractor {
    func checkLoginState(accountDetails: Binding<Loadable<AppState.UserData.AccountDetails>>)
}

struct AppAuthInteractor: AuthInteractor {
    let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func checkLoginState(accountDetails: Binding<Loadable<AppState.UserData.AccountDetails>>) {
        let cancelBag = CancelBag()
        authRepository.checkLoginState()
            .sinkToLoadable { accountDetails.wrappedValue = $0 }
            .store(in: cancelBag)
    }
    
}

struct StubAuthInteractor: AuthInteractor {
    func checkLoginState(accountDetails: Binding<Loadable<AppState.UserData.AccountDetails>>) {
    
    }
    
    
}
