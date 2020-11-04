//
//  Router.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 28/10/20.
//

import Foundation


typealias Parameters = [String: Any]
typealias Header = [String: String]
typealias queryParameters = [String: String]


enum Router {
    
    private struct Constants {
        static let searchKeyParameter = "q"
        static let itemsByCategoryParameter = "category"

    }
    
    case getCategories
    case filter(query: String)
    case getItemsByCategory(category: String)
    
    private var baseUrl: String { "https://api.mercadolibre.com/sites/MCO" }

    // MARK: - URL

    private enum URLPaths: String {
        case categories = "/categories"
        case filter = "/search"
    }
    
    private enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getCategories:
            return .get
        case .filter, .getItemsByCategory:
            return .post
        }
    }
    
    private var path: String {
        switch self {
        case .getCategories:
            return URLPaths.categories.rawValue
        case .filter, .getItemsByCategory:
            return URLPaths.filter.rawValue
        }
    }
    
    // MARK: - Parameters
    
    private var bodyParameters: Parameters? {
        switch self {
        case .getCategories, .filter, .getItemsByCategory:
            return nil
        }
    }
    
    private var headers: Header? {
        switch self {
        case .getCategories, .filter, .getItemsByCategory:
            return nil
        }
    }
    
    private var queryParameters: queryParameters?{
        switch self {
        case .getCategories:
            return nil
        case .filter(let query):
            return [Constants.searchKeyParameter : query]
        case .getItemsByCategory(let category):
            return [Constants.itemsByCategoryParameter : category, "limit": "6"]
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

extension URL {
    func appending(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else {
            return absoluteURL
        }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems

        return urlComponents.url ?? absoluteURL
    }
}
