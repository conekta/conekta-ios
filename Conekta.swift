//
//  Conekta.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//

import Foundation


class Conekta: NSObject, DeviceCollectorSDKDelegate {
    
    // DC params
    internal let dcCollectionUrl: String = "https://api.conekta.io/fraud_providers/kount/logo.htm"
    internal let dcMerchantId: String = "205000"
    internal let device = UIDevice()
    internal let dc = DeviceCollectorSDK(debugOn: true)
    
    let publicKey: String
    
    init(publicKey: String){
        self.publicKey = publicKey
    }
    
    internal func apiKeyAsBase64(apikey: String) -> String {
        let plainData: NSData = apikey.dataUsingEncoding(NSUTF8StringEncoding)!
        let apiKeyBase64Data: NSData = plainData.base64EncodedDataWithOptions(NSDataBase64EncodingOptions(0))
        let returnValue: String = NSString(data: apiKeyBase64Data, encoding: NSUTF8StringEncoding) as! String
        return returnValue
    }
    

    func createToken(card: Card, withSuccess success:()-> Void, withFailure failure:() -> Void ) {
        var data: AnyObject!
        var c = Connection(data: data)
        c.makeRequest(NSURL(string: "https://api.conekta.io/tokens")!, action: "POST",  apiKeyBase64: self.apiKeyAsBase64(self.publicKey), body: card.asJSONData())
        self.setDeviceCollector()
    }
    
    internal func setDeviceCollector() {
        dc.setDelegate(self)
        dc.setMerchantId(self.dcMerchantId)
        dc.setCollectorUrl(self.dcCollectionUrl)
        dc.collect(self.device.identifierForVendor.UUIDString)
    }
    
    func onCollectorStart() {
        println("START <<<<<<<")
    }
    
    func onCollectorSuccess() {
        println("SUCCESS <<<<<<<")
    }
    
    func onCollectorError(errorCode: NSInteger, error: NSError) {
        println("ERROR <<<<<<<<")
    }


}
