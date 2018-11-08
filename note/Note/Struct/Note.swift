//
//  Note.swift
//  note
//
//  Created by Arseniy Zorin on 25/10/2018.
//  Copyright © 2018 ArseniyZ. All rights reserved.
//

import Foundation

struct Note: Codable{
    var id: Int
    var name: String
    var text: String
    var createDate: String
}
