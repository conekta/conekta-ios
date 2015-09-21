//
//  ViewController.swift
//  ConektaExample
//
//  Created by Javier Murillo on 12/22/14.
//  Copyright (c) 2014 Conekta.io. All rights reserved.
//

import UIKit
import ConektaSDK

class ViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!;
    @IBOutlet var numberField: UITextField!;
    @IBOutlet var expMonthField: UITextField!;
    @IBOutlet var expYearField: UITextField!;
    @IBOutlet var ccField: UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tokenizeCard(sender : AnyObject) {
        let conekta = Conekta(publicKey: "key_UCmfYCRt5TdUA8ii0")
        
        let tarjeta = Card(last4: numberField.text!, name: nameField.text!, cvc: ccField.text!, exp_month: expMonthField.text!, exp_year: expYearField.text!)

        conekta.createToken(tarjeta, withSuccess: { (data) -> Void in
            print("Success:")
            print(data)
            }, withFailure: { (error) -> Void in
            print("Failure:")
            print(error)
        })
        
    }
    
}

