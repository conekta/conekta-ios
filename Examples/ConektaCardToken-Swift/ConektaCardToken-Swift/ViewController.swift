//
//  ViewController.swift
//  ConektaCardToken-Swift
//
//  Created by Julian Ceballos on 10/19/15.
//  Copyright © 2015 Conekta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var numberCardUI: UITextField!
    @IBOutlet weak var nameCardUI: UITextField!
    @IBOutlet weak var expMonthUI: UITextField!
    @IBOutlet weak var expYearUI: UITextField!
    @IBOutlet weak var cvcUI: UITextField!
    @IBOutlet weak var outTokenUI: UILabel!
    @IBOutlet weak var outUUID_UI: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tokenizeBtn(_ sender: UIButton) {
            
        let conekta = Conekta()
        conekta.delegate = self
        conekta.publicKey = "key_KJysdbf6PotS2ut2"
        conekta.collectDevice()
        
        let card = conekta.card()
        
        card?.setNumber(numberCardUI.text, name: nameCardUI.text, cvc: cvcUI.text , expMonth: expMonthUI.text, expYear: expYearUI.text)
        
        let token = conekta.token()
        token?.card = card
        
        token?.create(success: { (data) -> Void in
            if let data = data as NSDictionary? as! [String:Any]? {
                self.outTokenUI.text = data["id"] as? String
                self.outUUID_UI.text = conekta.deviceFingerprint()
            }
        }, andError: { (error) -> Void in
            //print(error)
        })
    }
}
