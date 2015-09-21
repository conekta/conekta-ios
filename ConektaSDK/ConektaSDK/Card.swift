//
//  Card.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//  Copyright (c) 2015 Conekta.io. All rights reserved.
//

import Foundation

class Card: NSObject {
    var last4: String
    var name: String
    var cvc: String
    var exp_month: String
    var exp_year: String
    
    private var _deviceFingerprint: String?
    var device_fingerprint: String? {
        get {
            return _deviceFingerprint
        }
        set {
            guard let nv = newValue else {
                _deviceFingerprint = ""
                return
            }
            
            _deviceFingerprint = nv.stringByReplacingOccurrencesOfString("-", withString: "", options: .LiteralSearch, range: nil)
        }
    }
    
    func toJSON() -> NSData {
        var count = UInt32()
        let properties = class_copyPropertyList(self.classForCoder, &count)
        
        var json = ["card":[String:AnyObject]()]
        
        for (var i: UInt32 = 0; i < count; i++) {
            let property = properties[Int(i)]
            let name = NSString(UTF8String: property_getName(property)) as? String

            if let n = name {
                json["card"]![n] = valueForKey(n)
            }
        }
        
        free(properties)
        do {
            return try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        } catch {
            return NSData()
        }
    }
    
    init(last4: String, name: String, cvc: String, exp_month: String, exp_year: String) {
        self.last4 = last4
        self.name = name
        self.cvc = cvc
        self.exp_month = exp_month
        self.exp_year = exp_year
        super.init()
        self.device_fingerprint = ""
    }
    
    
}