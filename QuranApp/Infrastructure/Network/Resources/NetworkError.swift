//
//  NetworkError.swift
//  NetworkInfra
//
//  Created by Mahmoud on 1/31/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    
    case cancelled
    case noInternetConnection
    case invalidData
    case internalServerError
    case unknownError(String)
    case unauthorized
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No internet connection"
        case .invalidData, .internalServerError:
            return "Something went wrong"
        case .unknownError(let error):
            return error
        case .unauthorized:
            return "Unauthorized"
        default:
            return ""
        }
    }
}
