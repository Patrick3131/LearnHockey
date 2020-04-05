//
//  FirebaseDocumentPublisher.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 05.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore

struct FirebaseDocumentPublisher {
    typealias myType = [String : Any]?
    var publisher: AnyPublisher<myType, Error>
    private var cancelBag = [AnyCancellable]()
    private let dataSubject = CurrentValueSubject<myType,Error>(nil)
    init(reference: DocumentReference) {
        publisher = dataSubject.eraseToAnyPublisher()
        let listener = reference.addSnapshotListener { [dataSubject] (documentSnaptshot, error) in
            if let error = error {
                print("Error fetching document: \(error) for reference \(reference)")
                dataSubject.send(completion: Subscribers.Completion<Error>.failure(error))
            }
            if let document = documentSnaptshot?.data() {
                dataSubject.send(document)
            }
        }
        AnyCancellable {
            listener.remove()
        }.store(in: &cancelBag)
    }
}
