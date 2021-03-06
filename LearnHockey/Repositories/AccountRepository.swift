//
//  UserRepository.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 04.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation

protocol AccountRepository {
    var auth: AuthRepository { get set }
    var premium: PremiumRepository { get set }
    
}

//class FirebaseUserRepository: UserRepository {
//    
//}
