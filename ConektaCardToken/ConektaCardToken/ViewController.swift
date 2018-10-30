//
//  ViewController.swift
//  ConektaCardToken
//
//  Created by Javier Castañeda on 10/30/18.
//  Copyright © 2018 Javier Castañeda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ckCard = CkCard(number: "4242424242424242",
                            cardholder: "Javier Castañeda",
                            expMonth: "10", expYear: "2022", cvv: "123")
        let request = ConektaRequest.tokenize(card: ckCard, APIKey: "key_KJysdbf6PotS2ut2")
        Network.request(request) { (result) in
            switch result {
            case .success(let token):
                print("Token card: \(token)" )
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

