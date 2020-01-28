//
//  PhotoObject.swift
//  PhotoJournal
//
//  Created by Juan Ceballos on 1/27/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import Foundation

struct PhotoObject: Codable {
    let imageData: Data
    let date: Date
    let identifier = UUID().uuidString
}
