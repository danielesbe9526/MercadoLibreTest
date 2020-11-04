//
//  Result.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 28/10/20.
//

import Foundation

enum Response<T> {
    case succes(value: T)
    case failure(error: ErrorType)
}
