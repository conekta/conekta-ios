//
//  Card.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//
//

import Foundation

struct Card {
    var last4: String
    var name: String
    var cvc: String
    var exp_month: String
    var exp_year: String
    func asJSONData() -> NSData {
        let params = "{\"card\":{\"name\": \"\(self.name)\", \"number\":  \(self.last4), \"cvc\": \(self.cvc), \"exp_month\":  \(self.exp_month), \"exp_year\":  \(self.exp_year)} }"
        return params.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    }
}