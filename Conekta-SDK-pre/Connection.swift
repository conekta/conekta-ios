//
//  Connection.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//  Copyright (c) 2015 Conekta.io. All rights reserved.
//

import Foundation

class Connection {
    var data: AnyObject!
    
    init(data: AnyObject!){
        self.data = data
    }
    
    func saveResponse( data: AnyObject ) -> Void{
        self.data = data
        print("Recived  \(data)")
    }
    
    func makeRequest(url: NSURL, action: String,  apiKeyBase64: String, body: NSData, success: (data: AnyObject) -> Void, failure: (error: NSError) -> Void) -> Void {
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration)
        let request = NSMutableURLRequest(URL: url)
        var sError: NSError?
        
        request.HTTPMethod = action
        request.addValue("Basic " + apiKeyBase64, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
        request.addValue("{\"agent\":\"Conekta Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")
        var headers = request.allHTTPHeaderFields!
        request.HTTPBody = body
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            if (error != nil) {
                failure(error: error)
            } else {
                success(data: self.parseJSON(data) as AnyObject)
            }
        }
    }
    
    func 
    
    func parseJSON(responseData: NSData) -> AnyObject {
        var jsonError : NSError?
        let jsonResult : AnyObject?
        do {
            jsonResult = try NSJSONSerialization.JSONObjectWithData(responseData, options: [])
        } catch let error as NSError {
            jsonError = error
            jsonResult = nil
        }
        return jsonResult!
    }
    
    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace?) -> Bool {
        return protectionSpace?.authenticationMethod == NSURLAuthenticationMethodServerTrust
    }
    
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge?) {
        if challenge?.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credentials = NSURLCredential(forTrust: challenge!.protectionSpace.serverTrust)
            challenge!.sender.useCredential(credentials, forAuthenticationChallenge: challenge!)
        }
        
        challenge?.sender.continueWithoutCredentialForAuthenticationChallenge(challenge!)
    }
}