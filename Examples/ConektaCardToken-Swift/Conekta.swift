//
//  Conekta.swift
//  ConektaSwift
//
//  Created by Eduardo Pacheco on 27/06/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import Foundation
import UIKit

public class Conekta: NSObject, URLSessionDelegate {

    // MARK: - Properties
    private let baseURI = "https://api.conekta.io"
    private lazy var deviceFingerprint: String = {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        return uuid.replacingOccurrences(of: "-", with: "")
    }()

    public var publicKey: String!
    public var number: String!
    public var name: String!
    public var cvc: String!
    public var expMonth: String!
    public var expYear: String!
    public var delegate: UIViewController?

    // MARK: - Init
    required public convenience init(withNumber number: String, name: String, cvc: String, expMonth: String, expYear: String) {
        self.init()
        self.number = number
        self.name = name
        self.cvc = cvc
        self.expMonth = expMonth
        self.expYear = expYear
    }

    // MARK: - Public Methods
    public func collectDevice() {
        let html = "<html style=\"background: blue;\"><head></head><body><script type=\"text/javascript\" src=\"https://conektaapi.s3.amazonaws.com/v0.5.0/js/conekta.js\" data-conekta-public-key=\"\(publicKey)\" data-conekta-session-id=\"\(deviceFingerprint)\"></script></body></html>"
        let web = UIWebView(frame: CGRect.zero)
        web.loadHTMLString(html, baseURL: nil)
        web.scalesPageToFit = true
        self.delegate?.view.addSubview(web)
    }

    public func createToken(onSuccess successHandler: @escaping (String) -> (), onError errorHandler: @escaping (Error) -> ()) {
        guard let apiBase64 = apiKeyBase64() else { errorHandler(createError(message: "Wrong API Key")); return }
        if let req = createRequest(apiKey: apiBase64) {
            let defaultSession = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
            let dataTask = defaultSession.dataTask(with: req) { [weak self] (data, response, error) in
                guard let this = self else { return }
                if error != nil { errorHandler(error!) }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<AnyHashable, AnyObject>
                        if let id = json["id"] {
                            successHandler(id as! String)
                        } else {
                            if json["object"] as! String == "error" {
                                let msg = json["message_to_purchaser"] as! String
                                errorHandler(this.createError(message: msg))
                            } else {
                                errorHandler(this.createError(message: "Token Creation Error"))
                            }
                        }
                    } catch {
                        errorHandler(this.createError(message: "Token Creation Error"))
                    }
                } else {
                    errorHandler(this.createError(message: "Connection Error"))
                }
            }
            dataTask.resume()
        }
    }

    // MARK: - Private Methods
    private func apiKeyBase64() -> String? {
        if let plainData = publicKey.data(using: .utf8) {
            let base64Data = plainData.base64EncodedData(options: .lineLength64Characters)
            return String(data: base64Data, encoding: .utf8)
        } else {
            return nil
        }
    }

    private func cardJSONData() -> Data {
        let json: String = "{\"card\":{\"name\": \"\(name!)\", \"number\": \"\(number!)\", \"cvc\": \"\(cvc!)\", \"exp_month\": \"\(expMonth!)\", \"exp_year\": \"\(expYear!)\", \"device_fingerprint\": \"\(deviceFingerprint)\" } }"
        return json.data(using: .utf8, allowLossyConversion: true)!
    }

    private func createError(message: String) -> NSError {
        return NSError(domain: "Request Error", code: 500, userInfo: [NSLocalizedDescriptionKey: message])
    }

    private func createRequest(apiKey: String) -> URLRequest? {
        if let tokenURL = URL(string: baseURI + "/tokens") {
            var urlRequest = URLRequest(url: tokenURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("Basic " + apiKey, forHTTPHeaderField: "Authorization")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            urlRequest.addValue("application/vnd.conekta-v0.3.0+json", forHTTPHeaderField: "Accept")
            urlRequest.addValue("{\"agent\":\"Conekta Conekta iOS SDK\"}", forHTTPHeaderField: "Conekta-Client-User-Agent")
            urlRequest.httpBody = cardJSONData()
            return urlRequest
        } else {
            return nil
        }
    }
}
