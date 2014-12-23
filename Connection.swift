//
//  Connection.swift
//  
//
//  Created by Javier Murillo on 12/22/14.
//
//

import Foundation

class Connection{
    var data: AnyObject!
    init(data: AnyObject!){
        self.data = data
    }
    
    func saveResponse( data: AnyObject ) -> Void{
        self.data = data
        println("Recived  \(data)")
    }
    
    func makeRequest(url: NSURL, action: String,  apiKeyBase64: String, body: NSData) -> Void {
        
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration)
        var request = NSMutableURLRequest(URL: url)
        var sError: NSError?
        
        request.HTTPMethod = action
        request.addValue("Basic " + apiKeyBase64, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
        request.addValue("{\"agent\":\"Conekta Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")
        var headers = request.allHTTPHeaderFields!
        request.HTTPBody = body
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            self.saveResponse(self.parseJSON(data) as AnyObject)
        }
    }
    
    func parseJSON(responseData: NSData) -> AnyObject{
        var jsonError : NSError?
        let jsonResult : AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData, options: nil, error: &jsonError)
        return jsonResult!
    }
}