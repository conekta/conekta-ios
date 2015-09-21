//
//  Conekta.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//  Copyright (c) 2015 Conekta.io. All rights reserved.
//

import UIKit

class Conekta: NSObject {
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

    func createToken(card: Card, withSuccess success:SuccessClosure, withFailure failure:ErrorClosure) {
        let c = Connection(data: nil)
        
        self.deviceCollect(UUID)
        card.device_fingerprint = UUID
        
        let url = Endpoint.Tokens.URL()
        c.sendRequest(url, apiKeyBase64: apiKeyAsBase64(publicKey), data: card.toJSON(), successHandler: success, errorHandler: failure)
    }
}

extension Conekta: DeviceCollectorSDKDelegate {
    func deviceCollect(uuid: String) {
        let dc = DeviceCollectorSDK(debugOn: false)
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