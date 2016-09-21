//
//  Token.swift
//  ConektaCardToken-Swift
//
//  Created by Ricardo Michel Reyes Martínez on 7/21/16.
//  Copyright © 2016 Conekta. All rights reserved.
//

import Foundation

class Token
{
    var baseURI = ""
    var publicKey = ""
    var resourceURI = ""
    
    var card: Card?
    var deviceFingerprint = ""
    
    init()
    {
        self.resourceURI = "/tokens"
    }
    
    convenience init(card: Card)
    {
        self.init()
        self.card = card
    }
    
    func create(completionHandler: (response: AnyObject) -> (), errorHandler: (error: NSError) -> ())
    {
        if let url = NSURL(string: "\(self.baseURI)\(self.resourceURI)")
        {
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            
            if let apiKey = self.apiKeyBase64(self.publicKey)
            {
                request.setValue("Basic \(apiKey)", forHTTPHeaderField: "Authorization")
            }
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
            request.setValue("{\"agent\":\"Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")
            request.HTTPBody = self.card?.jsonSerialization()
            
            let connection = Connection(request: request)
            connection.request(completionHandler, errorHandler: errorHandler)
        }
    }
    
    func apiKeyBase64(apiKey: String) -> String?
    {
        let plainData = apiKey.dataUsingEncoding(NSUTF8StringEncoding)
        
        if let apiKeyBase64Data = plainData?.base64EncodedDataWithOptions(.Encoding64CharacterLineLength)
        {
            return NSString(data: apiKeyBase64Data, encoding: NSUTF8StringEncoding) as? String
        }
        
        return nil
    }
}