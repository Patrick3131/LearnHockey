//
//  AuthRepository.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 01.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import Combine
import FirebaseAuth
protocol AuthRepository {
    func checkLoginState() -> AnyPublisher<AppState.UserData.AccountDetails,Error>
}

struct FirebaseAuthRepository: AuthRepository {
    func checkLoginState() -> AnyPublisher<AppState.UserData.AccountDetails, Error> {
        Auth.auth()
        return Future<AppState.UserData.AccountDetails,Error> { promise in
            _ = Auth.auth().addStateDidChangeListener { auth, user in
                print(user)
                print(auth)
                if let user = user {
                    promise(.success(AppState.UserData.AccountDetails(userUID: user.uid, loggedIn: true, premiumUser: false)))
                } else {
                    promise(.success(AppState.UserData.AccountDetails(userUID: nil, loggedIn: false, premiumUser: false)))
                }
                
            }
        }.eraseToAnyPublisher()
    }
}
