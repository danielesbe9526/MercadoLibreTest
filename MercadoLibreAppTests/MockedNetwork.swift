//
//  MockedNetwork.swift
//  MercadoLibreAppTests
//
//  Created by Daniel Beltran😎 on 1/11/20.
//

import Foundation

final class MockedNetwork {
    static let shared = MockedNetwork()
    
    private let config: URLSessionConfiguration
    private let session: URLSession
    
    private init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func request(router: MockedRouter, completion: @escaping (Response<Data>) -> ()) {
        do {
            try session.dataTask(with: router.request()){ (data, urlResponse, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        completion(.failure(error: .networkError))
                    }
                    
                    guard let statusCode = urlResponse?.getStatusCode, (200...299).contains(statusCode) else {
                        guard let errorCode = urlResponse?.getStatusCode else {
                            completion(.failure(error: .defaultError))
                            return
                        }
                        
                        self.handleErrorType(from: errorCode, completion: completion)
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(error: .defaultError))
                        return
                    }
                    
                    completion(.succes(value: data))
                }
            }
            .resume()
        } catch {
            completion(.failure(error: .defaultError))
        }
    }
    
    private func handleErrorType(from statusCode: Int, completion: @escaping (Response<Data>) -> ()) {
        let errorType: ErrorType
        
        switch statusCode {
        case 404:
            errorType = .notFound
        case 500:
            errorType = .serverError
        default:
            errorType = .defaultError
        }
        
        completion(.failure(error: errorType))
        return
    }
}

