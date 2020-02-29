//
//  ExercisesWebRepository.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 28.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import Combine


protocol ExercisesWebRepository {
    func loadExercises(category: Category) -> AnyPublisher<[Exercise],Error>
    func loadExerciseDetail(_ exerciseId : String) -> AnyPublisher<Exercise,Error>
}

import FirebaseFirestore
import CodableFirebase

struct FirebaseWebRepository: ExercisesWebRepository {
    
    var categorie = Category.games
    var store: Firestore
    
    
    func loadExercises(category: Category) -> AnyPublisher<[Exercise], Error> {
        let document = store.collection(category.rawValue)
        return Future<[Exercise], Error> { promise in
            document.getDocuments { documents, error in
                if let error = error {
                    promise(.failure(error))
                } else if let documents = documents {
                    var exercises = [Exercise]()
                    for document in documents.documents {
                        do {
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
        let document = store.collection(categorie.rawValue).document(exerciseId)
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
        self.categorie = Category.games
        self.store = Firestore.firestore()
    }
}
