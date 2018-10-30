//
//  Network.swift
//  ConektaCardToken
//
//  Created by Javier Castañeda on 10/30/18.
//  Copyright © 2018 Javier Castañeda. All rights reserved.
//

import UIKit

final class Network {
    static func request(_ request: NetworkRequest, completion: @escaping ((Result<CkToken>) -> Void)) {
        do {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let urlRequest = try request.toRequest()
            DispatchQueue.global(qos: .userInitiated).async {
                let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                    DispatchQueue.main.async {
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        guard let data = data else { return }
                        do {
                            let decoder = JSONDecoder()
                            let token = try decoder.decode(CkToken.self, from: data)
                            completion(.success(token))
                        } catch let e {
                            completion(.failure(e))
                        }
                    }
                }
                task.resume()
            }
            
        } catch let e {
            completion(.failure(e))
        }
    }
}
