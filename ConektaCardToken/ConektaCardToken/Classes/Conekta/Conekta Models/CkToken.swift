//
//  CkToken.swift
//  ConektaCardToken
//
//  Created by Javier Castañeda on 10/30/18.
//  Copyright © 2018 Javier Castañeda. All rights reserved.
//

import Foundation

struct CkToken: Codable {
    var id: String
    var livemode: Bool
    var isUsed: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case livemode
        case isUsed = "used"
    }
}
