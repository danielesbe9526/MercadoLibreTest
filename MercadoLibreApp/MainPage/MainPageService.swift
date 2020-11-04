//
//  MainPageService.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 31/10/20.
//

import Foundation
import UIKit

protocol MainPageDelegate {
    func fetchCategories(_ response: Response<[Category]>)
}
