//
//  Card.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//  Copyright (c) 2015 Conekta.io. All rights reserved.
//

import Foundation

struct Card {
    var last4: String
    var name: String
    var cvc: String
    var exp_month: String
    var exp_year: String
    var device_fingerprint: String
    
    func asJSONData() -> NSData {
        let params = "{\"card\":{\"name\": \"\(self.name)\", \"number\":  \(self.last4), \"cvc\": \(self.cvc), \"exp_month\":  \(self.exp_month), \"exp_year\": \(self.exp_year), \"device_fingerprint\": \"\(self.device_fingerprint)\" } }"
        return params.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    }
    
    mutating func setDeviceFingerprint(device_fingerprint: String) {
        self.device_fingerprint = device_fingerprint.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    init(last4: String, name: String, cvc: String, exp_month: String, exp_year: String) {
        self.last4 = last4
        self.name = name
        self.cvc = cvc
        self.exp_month = exp_month
        self.exp_year = exp_year
        self.device_fingerprint = ""
    }
}