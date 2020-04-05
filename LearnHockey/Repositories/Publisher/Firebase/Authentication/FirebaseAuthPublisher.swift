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

protocol CustomPublisher {
    associatedtype myType
    var publisher: AnyPublisher <myType?,Error> { get set }
}

class FirebaseAuthPublisher: CustomPublisher {
    typealias myType = User
    
    var publisher: AnyPublisher<myType?,Error>
    private var cancelBag = [AnyCancellable]()
    private let userSubject = CurrentValueSubject<User?,Error>(nil)
    
    init() {
        publisher = userSubject.eraseToAnyPublisher()
        let handle = Auth.auth().addStateDidChangeListener { [userSubject] (auth, user) in
            userSubject.send(user)
        }
        
        AnyCancellable {
            Auth.auth().removeStateDidChangeListener(handle)
        }.store(in: &cancelBag)
    }
    
}
