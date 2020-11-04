//
//  MainPageViewModel.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 31/10/20.
//

import Foundation
import UIKit

struct MainPageViewModel {
    
    var delegate: MainPageDelegate?
    var client = Client()
    
    func fetchCategories() {
        client.fetchCategories { (response) in
            switch response {
            case .succes(let object):
                delegate?.fetchCategories(.succes(value: object))
            case .failure(let error):
                delegate?.fetchCategories(.failure(error: error))
            }
        }
    }
    
    func searchItem(with text: String) {
        client.search(with: text) { (result) in
            switch result {
            case .succes(let object):
                delegate?.searchItem(.succes(value: object))
            case .failure(let error):
                delegate?.searchItem(.failure(error: error))
            }
        }
    }
    
    func fetchItemsBy(categories: [Category]) {
        
        var categoryAndItems: [String: [Result]] = [:]
        
        /// this methos was called three times the request to get 3 diferent Categories
        
        for _ in 1...3 {
            guard let randomElement = categories.randomElement() else {
                return
            }
            
            client.fetchItemsByCategoryParameter(with: randomElement.id) { (response) in
                switch response {
                case .succes(let object):
                    categoryAndItems[randomElement.name] = object.results
                    delegate?.fetchItemsByCategoryParameter(.succes(value: categoryAndItems))
                case .failure(let error):
                    delegate?.fetchItemsByCategoryParameter(.failure(error: error))
                }
            }
        }
        
    }
}
