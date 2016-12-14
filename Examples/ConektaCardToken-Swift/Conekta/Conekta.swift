//
//  Conekta.swift
//  ConektaCardToken-Swift
//
//  Created by F J Castaneda Ramos on 9/29/16.
//  Copyright © 2016 Conekta. All rights reserved.
//

import UIKit

class Conekta:NSObject{
    let apikey:String
    
    
    init(apikey:String) {
        self.apikey = apikey
    }
    
    func requestTokenFor(_ card:Card, completion:@escaping (_ token:Token?, _ error:Error?)->Void){
        DispatchQueue.global(qos: .userInitiated).async {
            let urlString = "https://api.conekta.io/tokens"
            if let url = URL(string: urlString){
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                let apiKeyBase64 = self.apiKeyAsBase64(self.apikey)
                request.addValue("Basic " + apiKeyBase64, forHTTPHeaderField: "Authorization")
                request.addValue("application/json", forHTTPHeaderField: "Content-type")
                request.addValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
                request.addValue("{\"agent\":\"Conekta Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")
                request.httpBody = card.jsonData()
                let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, responseULR, error) in
                    DispatchQueue.main.async {
                        if let e = error{
                            completion(nil, e)
                        }else{
                            do{
                                if let connData = data, let responseJSON = try JSONSerialization.jsonObject(with: connData, options: .allowFragments) as? [String:AnyObject], let token = Token.tokenFromDictionary(responseJSON){
                                    completion(token, nil)
                                }else{
                                    let e = NSError(domain: "NoToken", code: 400, userInfo: [NSLocalizedDescriptionKey:"No token object"])
                                    completion(nil, e)
                                }
                            }catch let e{
                                completion(nil ,e)
                            }
                        }
                    }
                })
                task.resume()
            }
        }
    }
    
    fileprivate func apiKeyAsBase64(_ apikey: String) -> String {
        let plainData: Data = apikey.data(using: String.Encoding.utf8)!
        let apiKeyBase64Data: Data = plainData.base64EncodedData(options: NSData.Base64EncodingOptions(rawValue: 0))
        let returnValue: String = NSString(data: apiKeyBase64Data, encoding: String.Encoding.utf8.rawValue) as! String
        return returnValue
    }
}

struct Card{
    var number: String
    var name: String
    var cvc: String
    var exp_month: String
    var exp_year: String
    
    func jsonData()->Data{
        let fingerPrint = UIDevice.current.identifierForVendor
        let card = ["name":self.name,
                    "number":self.number,
                    "cvc":self.cvc,
                    "exp_month":self.exp_month,
                    "exp_year":self.exp_year,
                    "device_fingerprint":fingerPrint!.uuidString]
        let params = ["card":card]
        do{
            let jsondata = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
            return jsondata
        }catch{
            return Data()
        }
    }
    
}

struct Token {
    var id: String
    var livemode: Bool
    var used: Bool
    init(id:String, livemode:Bool,used:Bool){
        self.id = id
        self.livemode = livemode
        self.used = used
    }
    static func tokenFromDictionary(_ dic:[String:AnyObject]) -> Token? {
        if let id = dic["id"] as? String, let livemode = dic["livemode"] as? Bool,let used = dic["used"] as? Bool{
            return Token(id: id, livemode: livemode, used: used)
        }
        return nil
    }
}
