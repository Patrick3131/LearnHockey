//
//  CRUD.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 28.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation
import Combine

protocol CRUDStorage {
    func create(_ data: Data, config: CRUDStorageConfig) -> AnyPublisher<String,Error>
    func update(_ data: Data, config: CRUDStorageConfig) -> AnyPublisher<String,Error>
    func delete(_ url: String) -> AnyPublisher<Bool,Error>
    func read(_ url: String) -> AnyPublisher<Data,Error>
}


protocol CRUDStorageConfig {
    var path: String { get }
    var contentType: String { get }
}


