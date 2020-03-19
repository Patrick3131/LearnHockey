//
//  FirebaseAuthPublisher.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 16.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import FirebaseAuth
import Combine

class FirebaseAuthPublisher {
    
    var userPublisher: AnyPublisher<User?,Error>
    private var cancelBar = [AnyCancellable]()
    private let userSubject = CurrentValueSubject<User?,Error>(nil)
    
    init() {
        userPublisher = userSubject.eraseToAnyPublisher()
        let handle = Auth.auth().addStateDidChangeListener { [userSubject] (auth, user) in
            userSubject.send(user)
        }
        
        AnyCancellable {
            Auth.auth().removeStateDidChangeListener(handle)
        }.store(in: &cancelBar)
    }
    
}
