//
//  Utils.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 3/11/20.
//

import Foundation

class Utils {
    static let shared = Utils()
    
    func formatPrice( _ price: Int?) -> String {
        guard let value = price else {
            return "0"
        }
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        guard let priceString = currencyFormatter.string(from: NSNumber(value: value)) else {
            return "\(value)"
        }
        
        return priceString
    }
}
