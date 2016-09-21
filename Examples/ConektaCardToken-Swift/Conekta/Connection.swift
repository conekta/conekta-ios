//
//  Connection.swift
//  ConektaCardToken-Swift
//
//  Created by Ricardo Michel Reyes Martínez on 7/21/16.
//  Copyright © 2016 Conekta. All rights reserved.
//

import Foundation

class Connection
{
    var url: NSURL?
    var request: NSMutableURLRequest?
    var apiKey = ""
        
    convenience init(request: NSMutableURLRequest)
    {
        self.init()
        self.request = request
    }
    
    func request(completionHandler: (response: AnyObject) -> (), errorHandler: (error: NSError) -> ())
    {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: configuration)
        
        if let request = request
        {
            let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
                if let error = error
                {
                    errorHandler(error: error)
                }
                else if let data = data
                {
                    do
                    {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        completionHandler(response: json)
                    }
                    
                    catch
                    {
                        print("Couldn't serialize json response")
                    }
                }
            })
            
            task.resume()
        }
    }
}