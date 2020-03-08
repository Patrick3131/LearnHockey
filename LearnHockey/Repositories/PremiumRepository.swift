//
//  PremiumRepository.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 04.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore



protocol PremiumRepository {
    func createPremium(user id: String, isPremium: Bool) -> AnyPublisher<Bool,Never>
    func deletePremium()
    func readPremium(user id: String?) -> AnyPublisher<Bool,Error>
    func updatePremium(user id: String, isPremium: Bool) -> AnyPublisher<Bool,Error>
    func listenPremium(user id: String, completion: @escaping (AnyPublisher<Bool,Error>) -> Void)
}

class FirebasePremiumRepository: PremiumRepository {
    
    private var dbName = "user"
    private var db: Firestore
    init() {
        self.db = Firestore.firestore()
    }
    
    deinit {
        stopListen()
    }
    
    private func stopListen() {
        if let listener = premiumListener {
            listener.remove()
        }
    }
    private var premiumListener: ListenerRegistration?
    
    func listenPremium(user id: String, completion: @escaping (AnyPublisher<Bool,Error>) -> Void) {
        print(id)
        premiumListener = db.collection(dbName).document(id).addSnapshotListener { documentSnapshot, error in
            completion(Future<Bool,Error>() { promise in
                guard let document = documentSnapshot else {
                    if let error = error {
                        print("Error fetching document: \(error)")
                        promise(.failure(error))
                    }
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty")
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                
                if let premium = data["premium"] {
                    if let premium = premium as? Bool {
                        promise(.success(premium))
                    }
                }
            }.eraseToAnyPublisher())
        }
    }
    
    
    func createPremium(user id: String, isPremium: Bool) -> AnyPublisher<Bool,Never> {
        let dic = ["premium":isPremium]
        return Future<Bool,Never> { [weak self] promise in
            guard let safeSelf = self else { return }
            safeSelf.db.collection(safeSelf.dbName).document(id).setData(dic, merge: true) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    promise(.success(isPremium))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func deletePremium() {
        
    }
    
    
    
    /// prefer to use listener function  https://firebase.google.com/docs/firestore/query-data/listen
    func readPremium(user id: String?) -> AnyPublisher<Bool,Error> {
        return Future<Bool,Error> { [weak self] promise in
            guard let safeSelf = self else { return }
            if id == nil {
                promise(.success(false))
            } else {
                let docRed = safeSelf.db.collection(safeSelf.dbName).document(id!)
                docRed.getDocument { snapshot, error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        if let data = snapshot?.data() {
                            if let premium = data["premium"] {
                                if let premium = premium as? Bool {
                                    promise(.success(premium))
                                }
                            }
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func updatePremium(user id: String, isPremium: Bool) -> AnyPublisher<Bool,Error> {
        return Empty().eraseToAnyPublisher()
//        return createPremium(user: id, isPremium: isPremium)
    }
    
    
}

