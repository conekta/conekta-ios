//
//  Card.swift
//  ConektaSwift
//
//  Created by Ricardo Michel Reyes Martínez on 7/21/16.
//  Copyright © 2016 Ricardo Michel Reyes Martínez. All rights reserved.
//

import Foundation

class Card
{
    var baseURI = ""
    var publicKey = ""
    var resourceURI = ""
    
    var number = ""
    var name = ""
    var cvc = ""
    var expMonth = ""
    var expYear = ""
    var deviceFingerprint = ""
    
    init()
    {
        self.resourceURI = "/cards"
    }
    
    convenience init(number: String, name: String, cvc: String, expMonth: String, expYear: String)
    {
        self.init()
        self.number = number
        self.name = name
        self.cvc = cvc
        self.expMonth = expMonth
        self.expYear = expYear
    }
    
    func jsonSerialization() -> NSData?
    {
        let json = ["card" : ["name": self.name, "number": self.number, "cvc": self.cvc, "exp_month": self.expMonth, "exp_year": expYear, "device_fingerprint": self.deviceFingerprint]]
        
        do
        {
            let data = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            return data
        }
        
        catch
        {
            print("Couldn't serialize card to json data")
        }
        
        return nil
    }
}