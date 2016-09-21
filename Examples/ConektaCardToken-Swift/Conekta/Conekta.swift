//
//  Conekta.swift
//  ConektaCardToken-Swift
//
//  Created by Ricardo Michel Reyes Martínez on 7/21/16.
//  Copyright © 2016 Conekta. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class Conekta
{
    var baseURI = ""
    var publicKey = ""
    var viewController: UIViewController?
    
    init()
    {
        self.baseURI = "https://api.conekta.io"
    }
    
    func deviceFingerprint() -> String?
    {
        let uuid = UIDevice.currentDevice().identifierForVendor?.UUIDString
        return uuid?.stringByReplacingOccurrencesOfString("-", withString: "")
    }
    
    func collectDevice()
    {
        if let fingerprint = deviceFingerprint()
        {
            let html = "<html style=\"background: blue;\"><head></head><body><script type=\"text/javascript\" src=\"https://conektaapi.s3.amazonaws.com/v0.5.0/js/conekta.js\" data-conekta-public-key=\"\(self.publicKey)\" data-conekta-session-id=\"\(fingerprint)\"></script></body></html>"
            
            if let vc = viewController
            {
                let wk = WKWebView(frame: vc.view.bounds)
                wk.loadHTMLString(html, baseURL: nil)
                self.viewController?.view.addSubview(wk)
            }
        }
    }
    
    func card(number: String, name: String, cvc: String, expMonth: String, expYear: String) -> Card
    {
        let card = Card(number: number, name: name, cvc: cvc, expMonth: expMonth, expYear: expYear)
        card.baseURI = self.baseURI
        card.publicKey = self.publicKey
        if let fingerprint = deviceFingerprint()
        {
            card.deviceFingerprint = fingerprint
        }
        
        return card
    }
    
    func token(card: Card) -> Token
    {
        let token = Token(card: card)
        token.baseURI = self.baseURI
        token.publicKey = self.publicKey
        if let fingerprint = deviceFingerprint()
        {
            token.deviceFingerprint = fingerprint
        }
        
        return token
    }
}