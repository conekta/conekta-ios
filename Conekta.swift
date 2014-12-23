//
//  Conekta.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//

import Foundation

class Conekta {
    let publicKey: String
    init(publicKey: String){
        self.publicKey = publicKey
    }
    
    func apiKeyAsBase64(apikey: String) -> String {
        let plainData: NSData = apikey.dataUsingEncoding(NSUTF8StringEncoding)!
        let apiKeyBase64Data: NSData = plainData.base64EncodedDataWithOptions(NSDataBase64EncodingOptions(0))
        let returnValue: String = NSString(data: apiKeyBase64Data, encoding: NSUTF8StringEncoding) as String
        return returnValue
    }
    

    func createToken(card: Card, withSuccess success:()-> Void, withFailure failure:() -> Void ){
        var data: AnyObject!
        var c = Connection(data: data)
        c.makeRequest(NSURL(string: "https://api.conekta.io/tokens")!, action: "POST",  apiKeyBase64: self.apiKeyAsBase64(self.publicKey), body: card.asJSONData())
        
    }

}