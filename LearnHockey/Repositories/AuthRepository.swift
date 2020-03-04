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
    func checkLoginState(completion: @escaping (AnyPublisher<AccountDetails,Error>) -> Void)
    func logOut()
}


class FirebaseUserRepository: AuthRepository {
    
    var handler: AuthStateDidChangeListenerHandle?
    
    deinit {
        stopListen()
    }
    
    func checkLoginState(completion: @escaping (AnyPublisher<AccountDetails,Error>) -> Void) {
        self.handler = Auth.auth().addStateDidChangeListener { auth, user in
            completion(Future<AccountDetails,Error> { promise in
                if let user = user {
                    print(user)
                    print(auth)
                    promise(.success(AccountDetails(userUID: user.uid,name: user.displayName, loggedIn: true, premiumUser: false)))
                } else {
                    promise(.success(AccountDetails(userUID: nil, loggedIn: false, premiumUser: false)))
                }
                }.eraseToAnyPublisher()
            )
        }
    }
    
    func logOut() {
        try? Auth.auth().signOut()
    }
    
    func createPremiumUser() {
        
    }

    
    private func stopListen() {
        if let handler = handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
}

