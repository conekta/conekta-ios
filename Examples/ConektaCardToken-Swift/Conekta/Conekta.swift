//
//  Conekta.swift
//  ConektaCardToken-Swift
//
//  Created by F J Castaneda Ramos on 9/29/16.
//  Copyright © 2016 Conekta. All rights reserved.
//

import UIKit

class Conekta: NSObject {
    let apiKey:String
    
    init(apiKey:String){
        self.apiKey = apiKey
    }
    
    func generateTokenFor(card:Card,success:(token:Token)->Void, error:(tokenError:NSError)->Void){
        let urlString = "https://api.conekta.io/tokens"
        if let url = NSURL(string: urlString){
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            let apiKeyBase64 = self.apiKeyAsBase64(apiKey)
            request.addValue("Basic " + apiKeyBase64, forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            request.addValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
            request.addValue("{\"agent\":\"Conekta Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")
            request.HTTPBody = card.jsonData()
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { (responseData, responseNSURL, connectionError) in
                if let connError = connectionError{
                    error(tokenError: connError)
                }else{
                    do{
                        let responseObj = try NSJSONSerialization.JSONObjectWithData(responseData!, options: NSJSONReadingOptions(rawValue: 0)) as! [String:AnyObject]
                        if let tokenGetted = Token.tokenFromDictionary(responseObj){
                            success(token: tokenGetted)
                        }else{
                            let noTokenError = NSError(domain: "NoTokenError", code: 400, userInfo: ["info":"No token object"])
                            error(tokenError: noTokenError)
                        }
                    }catch let e as NSError{
                        error(tokenError: e)
                    }
                }
            })
            task.resume()
        }else{
            let urlError = NSError(domain: "InvalidURL", code: 400, userInfo: ["info":"The url is not reachable"])
            error(tokenError: urlError)
        }
    }
    
    private func apiKeyAsBase64(apikey: String) -> String {
        let plainData: NSData = apikey.dataUsingEncoding(NSUTF8StringEncoding)!
        let apiKeyBase64Data: NSData = plainData.base64EncodedDataWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        let returnValue: String = NSString(data: apiKeyBase64Data, encoding: NSUTF8StringEncoding) as! String
        return returnValue
    }
}


struct Card{
    var number: String
    var name: String
    var cvc: String
    var exp_month: String
    var exp_year: String
    
    func jsonData()->NSData{
        let adID = UIDevice.currentDevice().identifierForVendor
        let card = ["name":self.name,
                    "number":self.number,
                    "cvc":self.cvc,
                    "exp_month":self.exp_month,
                    "exp_year":self.exp_year,
                    "device_fingerprint":adID!.UUIDString]
        let params = ["card":card]
        do{
            let jsondata = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted)
            return jsondata
        }catch{
            return NSData()
        }
    }
}

class Token:NSObject {
    var id: String
    var livemode: Bool
    var used: Bool
    init(id:String, livemode:Bool,used:Bool){
        self.id = id
        self.livemode = livemode
        self.used = used
    }
    class func tokenFromDictionary(dic:[String:AnyObject]) -> Token? {
        if let id = dic["id"] as? String, livemode = dic["livemode"] as? Bool,used = dic["used"] as? Bool{
            return Token(id: id, livemode: livemode, used: used)
        }
        return nil
    }
}