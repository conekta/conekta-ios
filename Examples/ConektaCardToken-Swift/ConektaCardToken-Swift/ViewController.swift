//
//  ViewController.swift
//  ConektaCardToken-Swift
//
//  Created by Julian Ceballos on 10/19/15.
//  Copyright © 2015 Conekta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tokenLabel: UILabel!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1: - Create the conekta object with the credit card info...
        let conekta = Conekta(withNumber: "4242424242424242", name: "Pancho Conekta", cvc: "123", expMonth: "10", expYear: "2018")

        // 2: - Add your public key (remember to use the specific key for the environment you are developing for (test - production)
        conekta.publicKey = "key_KJysdbf6PotS2ut2"

        // 3: - Set the conekta delegate...
        conekta.delegate = self

        // 4: - Collect the device session id...
        conekta.collectDevice()

        // 5: - Create the token for the card info...
        conekta.createToken(onSuccess: { [weak self] token in
            print("Success! Card Token: " + token)
            self?.tokenLabel.text = token
        }, onError: { [weak self] error in
            print("Error: " + error.localizedDescription)
            self?.tokenLabel.text = "Error: " + error.localizedDescription
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

