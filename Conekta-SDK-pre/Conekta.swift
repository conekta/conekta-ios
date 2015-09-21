//
//  Conekta.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//  Copyright (c) 2015 Conekta.io. All rights reserved.
//

import Foundation
import UIKit
import DeviceCollectorSDK

class Conekta: NSObject, DeviceCollectorSDKDelegate {
    private let publicKey: String
    
    init(publicKey: String) {
        self.publicKey = publicKey
        
        super.init()
    }
    
    private var UUID: String {
        guard let uuid = UIDevice().identifierForVendor?.UUIDString else {
            return ""
        }
        
        return uuid
    }
    
    internal func apiKeyAsBase64(apikey: String) -> String {
        let plainData: NSData = apikey.dataUsingEncoding(NSUTF8StringEncoding)!
        let apiKeyBase64Data: NSData = plainData.base64EncodedDataWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        let returnValue: String = NSString(data: apiKeyBase64Data, encoding: NSUTF8StringEncoding) as! String
        return returnValue
    }

    func createToken(var card: Card, withSuccess success:(data: AnyObject)-> Void, withFailure failure:(error: NSError) -> Void ) {
        let data: AnyObject!
        let c = Connection(data: data)
        
        self.deviceCollect(UUID)
        card.setDeviceFingerprint(UUID)
        
        c.makeRequest(NSURL(string: "https://api.conekta.io/tokens")!, action: "POST",  apiKeyBase64: self.apiKeyAsBase64(self.publicKey), body: card.asJSONData(), success: success, failure: failure)
    }
    
    func deviceCollect(var uuid: String) {
        var dc = DeviceCollectorSDK(debugOn: false)
        dc.setDelegate(self)
        dc.setMerchantId("205000")
        dc.setCollectorUrl("https://api.conekta.io/fraud_providers/kount/logo.htm")
        dc.collect(uuid)
    }
    
    func onCollectorStart() {}
    
    func onCollectorSuccess() {}
    
    func onCollectorError(errorCode: Int32, withError error: NSError!) {
        print(error)
    }
    
}
