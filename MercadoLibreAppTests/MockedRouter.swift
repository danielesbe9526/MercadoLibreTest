//
//  MockedRouter.swift
//  MercadoLibreAppTests
//
//  Created by Daniel Beltran😎 on 1/11/20.
//

import Foundation
//
//typealias Parameters = [String: Any]
//typealias Header = [String: String]
//typealias queryParameters = [String: String]
//

enum MockedRouter {
    
    private struct Constants {
        static let searchKeyParameter = "A"
    }
    
    case badUrl
    
    private var baseUrl: String { "https://api.mercadolibre.com/sites/MCO" }

    // MARK: - URL

    private enum URLPaths: String {
        case badUrl = "qwery"
    }
    
    private enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    private var method: HTTPMethod {
        switch self {
        case .badUrl:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .badUrl:
            return URLPaths.badUrl.rawValue
        }
    }
    
    // MARK: - Parameters
    
    private var bodyParameters: Parameters? {
        switch self {
        case .badUrl:
            return nil
        }
    }
    
    private var headers: Header? {
        switch self {
        case .badUrl:
            return nil
        }
    }
    
    private var queryParameters: queryParameters?{
        switch self {
        case .badUrl:
            return nil
        }
    }
    
    // MARK: - request
    
    func request() throws -> URLRequest {
        let urlString = baseUrl + path
        guard var url = URL(string: urlString) else {
            throw ErrorType.paseUrlFail
        }
        
        if let queryParameters = queryParameters {
            for query in queryParameters {
                url = url.appending(query.key, value: query.value)
            }
        }

        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 20)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for header in headers {
                request.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        if let parameters = bodyParameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                throw ErrorType.paseUrlFail
            }
        }
        
        return request
    }
}
