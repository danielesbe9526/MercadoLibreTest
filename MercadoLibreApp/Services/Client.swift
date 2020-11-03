//
//  Client.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 28/10/20.
//

import Foundation

protocol ClientProtocol {
    func fetchCategories(completion: @escaping (Response<[Category]>) -> ())
    func fetchItemsByCategoryParameter(with category: String, completion: @escaping (Response<SearchResponse>) -> ())
}

final class Client: ClientProtocol {
    func fetchItemsByCategoryParameter(with category: String, completion: @escaping (Response<SearchResponse>) -> ()) {
       
        Network.shared.request(router: .getItemsByCategory(category: category)) { (response) in
            switch response {
            case .succes:
                self.handleJsonResponse(result: response, decodeType: SearchResponse.self) { (result) in
                    switch result {
                    case .succes(let objects):
                        completion(.succes(value: objects))
                    case .failure(let error):
                        completion(.failure(error: error))
                    }
                }
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    
    func fetchCategories(completion: @escaping (Response<[Category]>) -> ()) {
        Network.shared.request(router: Router.getCategories) { (response) in
            switch response {
            case .succes:
                self.handleJsonResponse(result: response, decodeType: [Category].self) { (result) in
                    switch result {
                    case .succes(let categories):
                        completion(.succes(value: categories))
                    case .failure(let error):
                        completion(.failure(error: error))
                    }
                }
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func search(with query: String, completion: @escaping (Response<SearchResponse>) -> ()) {
        Network.shared.request(router: Router.filter(query: query)) { (response) in
            switch response {
            case .succes:
                self.handleJsonResponse(result: response, decodeType: SearchResponse.self) { (result) in
                    switch result {
                    case .succes(let objects):
                        completion(.succes(value: objects))
                    case .failure(let error):
                        completion(.failure(error: error))
                    }
                }
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    
    
    // MARK: - JSON Handling
    
    private func handleJsonResponse<Value: Decodable>(result: Response<Data>, decodeType: Value.Type, completion: (Response<Value>) -> ()) {
        switch result {
        case .succes(let jsonData):
            guard let parsedObjects = try? JSONDecoder().decode(decodeType.self, from: jsonData) else {
                completion(.failure(error: .jsonDecodeError))
                return
            }
            
            completion(.succes(value: parsedObjects))
            
        case .failure(let error):
            completion(.failure(error: error))
        }
    }
}
