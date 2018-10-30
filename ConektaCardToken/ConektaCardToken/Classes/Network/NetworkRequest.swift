//
//  URLRequest.swift
//  ConektaCardToken
//
//  Created by Javier Castañeda on 10/30/18.
//  Copyright © 2018 Javier Castañeda. All rights reserved.
//

import Foundation
enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
}

typealias HTTPHeaders = [String: String]
typealias RequestParameters = [String: Any]
typealias JSON = [String: Any]

protocol ParameterEncodable {
    func getBody() -> Data?
}

protocol NetworkRequest {
    var method: HTTPMethod { get }
    var baseURL: URL? { get }
    var endpoint: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: ParameterEncodable? { get }
    var timeout: TimeInterval { get }
}

extension NetworkRequest {
    var timeout: TimeInterval { return 15 }
    var headers: HTTPHeaders? { return .none }
    var baseURL: URL? { return URL(string: "https://api.conekta.io/") }
    
    func toRequest() throws -> URLRequest {
        guard let url = baseURL?.appendingPathComponent(endpoint) else {
            throw NetworkRequestError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        request.timeoutInterval = timeout
        var defaultHeaders = HTTPHeaders()
        defaultHeaders["Content-Type"] = "application/json"
        if let headers = headers {
            for (key, value) in headers {
                defaultHeaders[key] = value
            }
        }
        request.allHTTPHeaderFields = defaultHeaders
        request.httpBody = parameters?.getBody()
        return request
    }
}

enum NetworkRequestError: Error {
    case invalidURL
    case serializationError
    
    var localizedDescription: String { return "Something is wrong with the URL please check if the URL is correct" }
}
