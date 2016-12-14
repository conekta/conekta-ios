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
        
        let apikey = "key_KJysdbf6PotS2ut2"
        let card = Card(number: "4242424242424242", name: "Javier Castañeda", cvc: "123", exp_month: "10", exp_year: "2020")
        let conekta = Conekta(apikey: apikey)
        conekta.requestTokenFor(card) { (token, error) in
            if let e = error{
                print(e.localizedDescription)
            }else{
                dump(token)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

