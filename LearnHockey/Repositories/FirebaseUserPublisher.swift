//
//  FirebaseUserPublisher.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 04.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import CodableFirebase

class FirebaseUserPublisher<T:Decodable>: CustomPublisher {
    typealias myType = T
    var publisher: AnyPublisher<myType?, Error>
    private var cancelBag = [AnyCancellable]()
    private let detailsSubject = CurrentValueSubject<myType?,Error>(nil)
    private var db = Firestore.firestore()
    init() {
        publisher = detailsSubject.eraseToAnyPublisher()
    }
    
    func startListening(dbName: String, user id: String) {
        let listener = db.collection(dbName).document(id).addSnapshotListener { [detailsSubject] (documentSnapshort, error) in
            guard let document = documentSnapshort else {
                if let error = error {
                    print("Error fetching document: \(error)")
                }
                return
            }
            guard let data = document.data() else {
                print("Document data was empty")
                return
            }
            
            do {
                let decoded = try FirestoreDecoder().decode(T.self, from: data)
                detailsSubject.send(decoded)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        AnyCancellable {
            listener.remove()
        }.store(in: &cancelBag)
        
    }
}




