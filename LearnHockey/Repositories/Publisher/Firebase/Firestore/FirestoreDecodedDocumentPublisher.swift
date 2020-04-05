//
//  FirestoreDecodedDocumentPublisher.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 05.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import Combine
import CodableFirebase
import FirebaseFirestore

struct FirestoreDecodedDocumentPublisher<T:Decodable> {
    var publisher: AnyPublisher<T,Error>
    init(reference:DocumentReference) {
        let publisher = FirestoreDocumentPublisher(reference: reference).publisher
        self.publisher = publisher.flatMap { data in
            return Just(data)
                .compactMap { $0}
                .decode(type: T.self, decoder: FirestoreDecoder())
        }.eraseToAnyPublisher()
    }
}


