//
//  Conekta.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//  Copyright (c) 2015 Conekta.io. All rights reserved.
//

import Foundation


class Conekta: NSObject, DeviceCollectorSDKDelegate {
    
    let publicKey: String
    
    init(publicKey: String) {
        self.publicKey = publicKey
    }
    
    internal func getUUID() -> String {
        var device_fingerprint = UIDevice().identifierForVendor.UUIDString
        return device_fingerprint.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    internal func apiKeyAsBase64(apikey: String) -> String {
        let plainData: NSData = apikey.dataUsingEncoding(NSUTF8StringEncoding)!
        let apiKeyBase64Data: NSData = plainData.base64EncodedDataWithOptions(NSDataBase64EncodingOptions(0))
        let returnValue: String = NSString(data: apiKeyBase64Data, encoding: NSUTF8StringEncoding) as! String
        return returnValue
    }

    func createToken(var card: Card, withSuccess success:()-> Void, withFailure failure:() -> Void ) {
        var data: AnyObject!
        var c = Connection(data: data)
        var device_fingerprint = self.getUUID()
        
        self.deviceCollect(device_fingerprint)
        card.setDeviceFingerprint(device_fingerprint)
        
        c.makeRequest(NSURL(string: "https://api.conekta.io/tokens")!, action: "POST",  apiKeyBase64: self.apiKeyAsBase64(self.publicKey), body: card.asJSONData())
    }
    
    func deviceCollect(var device_fingerprint: String) {
        var dc = DeviceCollectorSDK(debugOn: false)
        dc.setDelegate(self)
        dc.setMerchantId("205000")
        dc.setCollectorUrl("https://api.conekta.io/fraud_providers/kount/logo.htm")
        dc.collect(device_fingerprint)
    }
    
    func onCollectorStart() {}
    
    func onCollectorSuccess() {}
    
    func onCollectorError(errorCode: Int32, withError error: NSError!) {
        println(error)
    }
    
}
