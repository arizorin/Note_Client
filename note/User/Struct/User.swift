//
//  User.swift
//  note
//
//  Created by Arseniy Zorin on 27/10/2018.
//  Copyright © 2018 ArseniyZ. All rights reserved.
//

import Foundation

struct User: Decodable, Encodable{
    var id: Int
    var token: String
}
