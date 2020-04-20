//
//  KingfisherBridge.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 28.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import Foundation

import Foundation
import KingfisherSwiftUI


//Kingfisher contains some general purpose types like Kingfisher.Image and Kingfisher.View. If you import the whole SwiftUI and Kingfisher at the same time, you will suffer from a name conflict. To avoid that, only import the necessary types from Kingfisher, such as import struct Kingfisher.KFImage or import class Kingfisher.KingfisherManager.
//https://github.com/onevcat/Kingfisher/wiki/SwiftUI-Support

typealias CachedImage = KFImage
