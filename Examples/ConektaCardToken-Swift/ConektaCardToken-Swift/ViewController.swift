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
        
        conekta.delegate = self
        
        conekta.publicKey = "key_KJysdbf6PotS2ut2"
        
        conekta.collectDevice()
        
        let card = conekta.Card()
        
        card.setNumber("4242424242424242", name: "Julian Ceballos", cvc: "123", expMonth: "10", expYear: "2018")
        
        let token = conekta.Token()
        
        token.card = card
        
        token.createWithSuccess({ (data) -> Void in
            print(data)
            }, andError: { (error) -> Void in
                print(error)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

