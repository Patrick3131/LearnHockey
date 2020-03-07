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
    func checkLoginState(completion: @escaping (AnyPublisher<AccountDetails,Error>) -> Void)
    func logOut()
}



class FirebaseUserRepository: AuthRepository {
    
    var handler: AuthStateDidChangeListenerHandle?
    
    private var dbName = "user"
    private var db: Firestore
    init() {
        self.db = Firestore.firestore()
    }
    
    deinit {
        stopListen()
    }
    
    
    func subscriber() {
        
    }
    
    func checkLoginState(completion: @escaping (AnyPublisher<AccountDetails,Error>) -> Void) {
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
                                safeSelf.createEmptyUser(user: user.uid) { result in
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
    
    func logOut() {
        try? Auth.auth().signOut()
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
    
    
    private func createEmptyUser(user id: String, completion: @escaping (Result<Bool,Error>) -> Void) {
        let dic = ["premium":false]
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
    
    private func checkIfUserIsInDatabase(user id: String) -> AnyPublisher<Bool,Error> {
        return Future<Bool,Error>( { [weak self] promise in
            guard let safeSelf = self else { return }
            let docRef = safeSelf.db.collection(safeSelf.dbName).document(id)
            docRef.getDocument { document, error in
                if let document = document {
                    if document.exists {
                        promise(.success(true))
                    } else {
                        print("This is the first login, user: \(id) will be added to Firestore now.")
                        promise(.success(false))
                        safeSelf.createEmptyUser(user: id)
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
    
    func createPremiumUser() {
        
    }

    
    private func stopListen() {
        if let handler = handler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
}




                    
//                    safeSelf.checkIfUserIsInDatabase(user: user.uid)
//                        .sinkToResult { value in
//                            switch value {
//                            case .success(let isUserInDatabase):
//                                if isUserInDatabase {
//                                    promise(.success(AccountDetails(userUID: user.uid,name: user.displayName, loggedIn: true, premiumUser: false)))
//                                } else {
//                                    safeSelf.createEmptyUser(user: user.uid)
//                                        .sinkToResult { value in
//                                            switch value {
//                                            case .success( _):
//                                                promise(.success(AccountDetails(userUID: user.uid,name: user.displayName, loggedIn: true, premiumUser: false)))
//                                            case .failure(let error):
//                                                print(error)
//                                            }
//                                    }
//                                }
//                            case .failure(let error):
//                                print(error)
//                            }
//
//                    }
