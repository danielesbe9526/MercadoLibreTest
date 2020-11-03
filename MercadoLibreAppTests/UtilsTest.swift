//
//  UtilsTest.swift
//  MercadoLibreAppTests
//
//  Created by Daniel Beltran😎 on 3/11/20.
//

import XCTest
@testable import MercadoLibreApp

class UtilsTest: XCTestCase {
    
    func test_format_price() {
        XCTAssert( Utils.shared.formatPrice(1000000) == "$1,000,000.00")
    }
    
}
