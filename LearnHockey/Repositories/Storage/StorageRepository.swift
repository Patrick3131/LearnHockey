//
//  StorageRepository.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 28.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Combine
import FirebaseStorage

extension StorageReference {
    /// https://gist.github.com/gilbox/1a19e1e18ffcaa70e7d6b0fe0e837e10
//    var downloadURLPublisher: AnyPublisher<URL,Error> {
//        Future<URL
//    }
}

struct StorageRepository: CRUDStorage {
    let storage: Storage
    func create(_ data: Data, config: CRUDStorageConfig) -> AnyPublisher<String, Error> {
        Empty().eraseToAnyPublisher()
    }
    
    func update(_ data: Data, config: CRUDStorageConfig) -> AnyPublisher<String, Error> {
        Empty().eraseToAnyPublisher()
    }
    
    func delete(_ url: String) -> AnyPublisher<Bool, Error> {
        Empty().eraseToAnyPublisher()
    }
    
    func read(_ url: String) -> AnyPublisher<Data, Error> {
        let reference = storage.reference().child(url)
        return Future<Data,Error> { promise in
            reference.getData(maxSize: 1 * 1024 * 1024, completion: { data, error in
                if let error = error {
                    promise(.failure(error))
                } else if let data = data {
                    promise(.success(data))
                }
            })
        }.eraseToAnyPublisher()
    }
}
