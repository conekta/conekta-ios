//
//  Endpoints.swift
//  ConektaSDK
//
//  Created by Swanros on 9/21/15.
//  Copyright © 2015 Conekta.io. All rights reserved.
//

import Foundation

private let api_base = "https://api.conekta.io/"

enum Endpoint: String {
    case Tokens = "tokens"
    
    func URL() -> NSURL {
        return NSURL(string: api_base + self.rawValue)!
    }
}