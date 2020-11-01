//
//  MainPageViewModel.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 31/10/20.
//

import Foundation
import UIKit

typealias  imageViewModelCompletionClosure = (_ result: Response<UIImage>) -> ()


struct MainPageViewModel {
    
    var mainPageService: MainPageService?

    func downloadImages(with url: String, completion: @escaping imageViewModelCompletionClosure) {
        mainPageService?.downloadImages(with: url, completion: { (response) in
            switch response {
            case .succes(let image):
                completion(.succes(value: image))
            case .failure(let error):
                completion(.failure(error: error))
            }
        })
    }
}
