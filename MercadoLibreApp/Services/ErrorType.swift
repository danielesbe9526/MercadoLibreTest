//
//  ErrorType.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 28/10/20.
//

import Foundation
import Network

enum ErrorType: LocalizedError, Error {
    case networkError
    case formatError
    case paseUrlFail
    case notFound
    case serverError
    case defaultError
    case jsonDecodeError
    
    var errorDescription: String {
        switch self {
        case .networkError:
            return "Please check your internet connection and try again."
        case .serverError:
            return "The server is not working, please try again latter"
        case .jsonDecodeError:
            return "Failed To Decode Data To Json Model"
        default:
        return self.errorDescription
        }
    }
}
