//
//  ViewController.swift
//  ConektaCardToken-Swift
//
//  Created by Julian Ceballos on 10/19/15.
//  Copyright © 2015 Conekta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let conekta = Conekta()
        
        conekta.viewController = self
        
        conekta.publicKey = "key_KJysdbf6PotS2ut2"
        
        //conekta.collectDevice()
        
        let card = conekta.card("4242424242424242", name: "Julian Ceballos", cvc: "123", expMonth: "10", expYear: "2018")
        
        let token = conekta.token(card)
        
        token.create({ (response) in
            print("Token response: \(response)")
        })
        { (error) in
            print("Token error: \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

