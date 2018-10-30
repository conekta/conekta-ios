//
//  Result.swift
//  ConektaCardToken
//
//  Created by Javier Castañeda on 10/30/18.
//  Copyright © 2018 Javier Castañeda. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

// MARK: - CustomStringConvertible
extension Result: CustomStringConvertible {
    /// The textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure.
    public var description: String {
        switch self {
        case .success:
            return "SUCCESS"
        case .failure:
            return "FAILURE"
        }
    }
}

// MARK: - CustomDebugStringConvertible
extension Result: CustomDebugStringConvertible {
    /// The debug textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure in addition to the value or error.
    public var debugDescription: String {
        switch self {
        case .success(let value):
            return "SUCCESS: \(value)"
        case .failure(let error):
            return "FAILURE: \(error)"
        }
    }
}
