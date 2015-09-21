//
//  Connection.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//  Copyright (c) 2015 Conekta.io. All rights reserved.
//

import Foundation

public typealias SuccessClosure = AnyObject? -> ()
public typealias ErrorClosure = NSError -> ()

class Connection: NSObject {
    var data: AnyObject?
    
    init(data: AnyObject?){
        self.data = data
    }
    
    func saveResponse( data: AnyObject ) -> Void{
        self.data = data
        print("Recived  \(data)")
    }
    
    func sendRequest(url: NSURL, apiKeyBase64: String, data: NSData, successHandler: SuccessClosure, errorHandler: ErrorClosure) {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.addValue("Basic " + apiKeyBase64, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/vnd.conekta-v0.4.0+json", forHTTPHeaderField: "Accept")
        request.addValue("{\"agent\":\"Conekta Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")
        
        request.HTTPBody = data
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard let d = data else {
                if let e = error { errorHandler(e) }
                return
            }
            
            successHandler(self.parseJSON(d))
        }
        
        task.resume()
    }
    
    private func parseJSON(responseData: NSData) -> AnyObject? {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
            return json
        } catch {
            return nil
        }
    }
    
}

extension Connection: NSURLSessionDelegate {
    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credentials = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            challenge.sender?.useCredential(credentials, forAuthenticationChallenge: challenge)
        }
    }
}