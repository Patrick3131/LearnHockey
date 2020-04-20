//
//  FirebaseWebRepository.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation

import FirebaseFirestore
import CodableFirebase
import Combine

struct FirebaseWebRepository: ExercisesWebRepository {
    
    var categorie = Category(name: "games")
    var store: Firestore
    
    
    func loadExercises(category: Category) -> AnyPublisher<[Exercise], Error> {
        let document = store.collection(category.name)
        return Future<[Exercise], Error> { promise in
            document.getDocuments { documents, error in
                if let error = error {
                    promise(.failure(error))
                } else if let documents = documents {
                    var exercises = [Exercise]()
                    for document in documents.documents {
                        do {
                            /// if there is one variable missing in the firebase document, then it does not decode at all, might has to change to a different approach
                            let decoded = try FirestoreDecoder().decode(Exercise.self, from: document.data())
                            exercises.append(decoded)
                        } catch let error {
                            promise(.failure(error))
                        }
                    }
                    promise(.success(exercises))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func loadExerciseDetail(_ exerciseId: String) -> AnyPublisher<Exercise, Error> {
//        das mit den categorien muss noch umimplementiert werden
        let document = store.collection(categorie.name).document(exerciseId)
        return Future<Exercise,Error> { promise in
            document.getDocument { document, error in
                if let error = error {
                    promise(.failure(error))
                } else if let document = document {
                    if let data = document.data() {
                        do {
                            let decoded = try FirestoreDecoder().decode(Exercise.self, from: data)
                            promise(.success(decoded))
                        } catch let error {
                            promise(.failure(error))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
}




extension FirebaseWebRepository {
    init() {
        self.categorie = Category(name: "games")
        self.store = Firestore.firestore()
    }
}
