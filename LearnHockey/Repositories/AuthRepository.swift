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
import FirebaseFirestore


protocol AuthRepository {
    func logOut()
    func checkLoginState() -> AnyPublisher<AccountDetails,Error>
    func checkLoginState(completion: @escaping (AnyPublisher<AccountDetails,Error>) -> Void)
}



class FirebaseUserRepository: AuthRepository {
    
    var handler: AuthStateDidChangeListenerHandle?
    var storage = Set<AnyCancellable>()

    private var dbName = "user"
    private var db: Firestore
    
    init() {
        self.db = Firestore.firestore()
    }
    
    deinit {
        stopListen()
    }
    
    private func stopListen() {
        if let handler = handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
    
    lazy var authPublisher = FirebaseAuthPublisher()
    
    func checkLoginState() -> AnyPublisher<AccountDetails,Error> {
        authPublisher.userPublisher
            .print()
            .flatMap(
                ifSome: { [weak self] (user: User) -> AnyPublisher<AccountDetails,Error> in
                    guard let safeSelf = self else { return Empty().eraseToAnyPublisher() }
                    return safeSelf.handleUserInDatabase(user: user.uid)
                        .flatMap { result -> AnyPublisher<AccountDetails,Error> in
                            Just<AccountDetails>(AccountDetails(user)).setFailureType(to: Error.self).eraseToAnyPublisher()
                    }.eraseToAnyPublisher()
                }, ifNone: { () -> AnyPublisher<AccountDetails,Error> in
                    Just<AccountDetails>(AccountDetails(userUID: nil, name: nil, loggedIn: false, premiumUser: false)).setFailureType(to: Error.self).eraseToAnyPublisher()
            })
    }
    
    func checkLoginState(completion: @escaping (AnyPublisher<AccountDetails,Error>) -> Void) {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let safeSelf = self else { return }
            completion(Future<AccountDetails,Error> { promise in
                if let user = user {
                    safeSelf.handleUserInDatabase(user: user.uid)
                    .sink(receiveCompletion: { completion in
                        if let error = completion.error  {
                            print(error.localizedDescription)
                            promise(.failure(error))
                        }
                    }, receiveValue: { result in
                        if result {
                            promise(.success(AccountDetails(userUID: user.uid,name: user.displayName, loggedIn: true, premiumUser: false)))
                        }
                    }).store(in: &safeSelf.storage)
                } else {
                    promise(.success(AccountDetails(userUID: nil, loggedIn: false, premiumUser: false)))
                }
            }.eraseToAnyPublisher())
        }
    }
    
    
    func logOut() {
        try? Auth.auth().signOut()
    }
    
    /// Checks if User exists in Firestore, if not creates an empty User and returns true
    private func handleUserInDatabase(user: String) -> AnyPublisher<Bool,Error> {
        return Future<Bool,Error>( { [weak self] promise in
            guard let safeSelf = self else { return }
            safeSelf.checkIfUserIsInDatabase(user: user)
                .flatMap { result -> AnyPublisher<Bool,Error> in
                    if result == false {
                        return safeSelf.createEmptyUser(user: user).eraseToAnyPublisher()
                    } else {
                        promise(.success(true))
                        return Empty<Bool,Error>(completeImmediately: true).eraseToAnyPublisher()
                    }}
                .sink(receiveCompletion: { completion in
                    if let error = completion.error {
                        promise(.failure(error))
                    }}, receiveValue: {promise(.success($0))})
                .store(in:&safeSelf.storage)
            }
        ).eraseToAnyPublisher()
    }
    
    private func checkIfUserIsInDatabase(user id: String) -> AnyPublisher<Bool,Error> {
        return Future<Bool,Error>( { [weak self] promise in
            guard let safeSelf = self else { return }
            let docRef = safeSelf.db.collection(safeSelf.dbName).document(id)
            docRef.getDocument { document, error in
                if let document = document {
                    if document.exists {
                        promise(.success(true))
                    } else {
                        print("This is the first login of user: \(id), user will be added to Firestore now.")
                        promise(.success(false))
                    }
                }
            }
        }).eraseToAnyPublisher()
        
    }
    
    
    
    private func createEmptyUser(user id: String) -> AnyPublisher<Bool,Error> {
        return Future<Bool,Error>( { [weak self] promise in
            guard let safeSelf = self else { return }
            let dic = ["premium":false]
            safeSelf.db.collection(safeSelf.dbName).document(id).setData(dic, merge: true) { error in
                if let error = error {
                    print(error.localizedDescription)
                    promise(.failure(error))
                } else {
                    print("User:\(id) was successfully added to Firestory" )
                    promise(.success(true))
                }
            }
        }).eraseToAnyPublisher()
    }
    
    // MARK: - Completionhandler functions
    
    private func checkLoginStateCompletionHandlerVersion(completion: @escaping (AnyPublisher<AccountDetails,Error>) -> Void) {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let safeSelf = self else { return }
            completion(Future<AccountDetails,Error> { promise in
                if let user = user {
                    print(user)
                    print(auth)

                    safeSelf.checkIfUserIsInDatabase(user: user.uid) { result in
                        switch result {
                        case .success(let isAvailable):
                            if isAvailable {
                                 promise(.success(AccountDetails(userUID: user.uid,name: user.displayName, loggedIn: true, premiumUser: false)))
                            } else {
                                safeSelf.createEmptyUser(user: user.uid,email: user.email) { result in
                                    switch result {
                                    case .success(_):
                                        promise(.success(AccountDetails(userUID: user.uid,name: user.displayName, loggedIn: true, premiumUser: false)))
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                } else {
                    promise(.success(AccountDetails(userUID: nil, loggedIn: false, premiumUser: false)))
                }
                }.eraseToAnyPublisher()
            )
        }
    }
    
    private func checkIfUserIsInDatabase(user id: String, completion: @escaping (Result<Bool,Error>) -> Void) {
        let docRef = db.collection(dbName).document(id)
        docRef.getDocument { document, error in
            if let document = document {
                if document.exists {
                    completion(.success(true))
                } else {
                    print("This is the first login, user: \(id) will be added to Firestore now.")
                    completion(.success(false))
                }
            }
        }
    }
    
    
    private func createEmptyUser(user id: String, email:String?, completion: @escaping (Result<Bool,Error>) -> Void) {
        let dic: [String:Any] = ["premium":false, "email" : email ?? ""]
        db.collection(dbName).document(id).setData(dic, merge: true) { error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            } else {
                print("User:\(id) was successfully added to Firestory" )
                completion(.success(true))
            }
        }
    }
    
    
   
}
