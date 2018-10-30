//
//  ConektaRequest.swift
//  ConektaCardToken
//
//  Created by Javier Castañeda on 10/30/18.
//  Copyright © 2018 Javier Castañeda. All rights reserved.
//

import Foundation

enum ConektaRequest: NetworkRequest {
    case tokenize(card: CkCard, APIKey: String)
    
    var headers: HTTPHeaders? {
        switch self {
        case .tokenize(_, let APIKey):
            var headers = HTTPHeaders()
            headers["Accept"] = "application/vnd.conekta-v0.3.0+json"
            headers["Conekta-Client-User-Agent"] = "{\"agent\":\"Conekta Conekta iOS SDK\"}"
            if let apikey64 = stringBase64(with: APIKey) {
                headers["Authorization"] = "Basic " + apikey64
            }
            
            return headers
        }
    }
    var method: HTTPMethod { return .post }
    var endpoint: String { return "tokens" }
    var parameters: ParameterEncodable? {
        switch self {
        case .tokenize(let card, _): return card
        }
    }
    
    private func stringBase64(with string: String) -> String? {
        guard let plainData = string.data(using: .utf8) else { return nil }
        let apiKeyBase64Data: Data = plainData.base64EncodedData(options: NSData.Base64EncodingOptions(rawValue: 0))
        let retValue = String(data: apiKeyBase64Data, encoding: .utf8)
        return retValue
    }
}
