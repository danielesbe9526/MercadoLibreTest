//
//  MainPageService.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 31/10/20.
//

import Foundation
import UIKit

typealias GetImagesCompletionClosure = (_ result: Response<UIImage>) -> ()


protocol MainPageService {
    func downloadImages(with url: String, completion: @escaping GetImagesCompletionClosure)
}
