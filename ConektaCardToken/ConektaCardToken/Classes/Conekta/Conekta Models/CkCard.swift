//
//  CkCard.swift
//  ConektaCardToken
//
//  Created by Javier Castañeda on 10/30/18.
//  Copyright © 2018 Javier Castañeda. All rights reserved.
//

import Foundation

struct CkCard: Codable {
    var number: String
    var cardholder: String
    var expMonth: String
    var expYear: String
    var cvv: String
    
    enum CodingKeys: String, CodingKey {
        case number
        case cardholder = "name"
        case expMonth   = "exp_month"
        case expYear    = "exp_year"
        case cvv        = "cvc"
        
    }
    
    init(number: String, cardholder: String, expMonth: String, expYear: String, cvv: String) {
        self.number = number
        self.cardholder = cardholder
        self.expMonth = expMonth
        self.expYear = expYear
        self.cvv = cvv
    }
    
    func toData() throws {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let card = ["card": self]
        let data = try jsonEncoder.encode(card)
        print(String(data: data, encoding: .utf8) ?? "No data")
    }
}

extension CkCard: ParameterEncodable {
    func getBody() -> Data? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let card = ["card": self]
        do {
            let data = try jsonEncoder.encode(card)
            return data
        } catch { return nil }
    }
}
