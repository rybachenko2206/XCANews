//
//  ApiMethod.swift
//  XCANews
//
//  Created by Roman Rybachenko on 05.06.2022.
//

import Foundation

enum APIMethod {
    case getNews(category: Category)
    
    
    private static let baseURL: URL = URL(string: "https://newsapi.org/v2/top-headlines")!
    private static let apiKey = "cfa8881a6a1a4fdc81a2950f19955a30"
    
    var urlRequest: URLRequest? {
        guard let url = self.url,
            var urlComp = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else { return nil }
        
        urlComp.queryItems = requestParameters.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        
        guard let finalUrl = urlComp.url else { return nil}
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
    private var httpMethod: String {
        switch self {
        case .getNews:
            return "GET"
        }
    }
    
    private var url: URL? {
        return APIMethod.baseURL
    }
    
    private var headers: [String: String] {
        let headerFields: [String: String] = [:]
        
        return headerFields
    }
    
    private var requestParameters: [String: String] {
        var parameters: [String: String] = [
            Keys.kApiKey: APIMethod.apiKey,
            Keys.kLanguage: "en"
        ]
        
        switch self {
        case .getNews(let category):
            parameters[Keys.kCategory] = category.rawValue
        default:
            break
        }
        
        return parameters
    }
    
}

struct Keys {
    // For request parameters
    static let kQuery = "q"
    static let kLanguage = "language"
    static let kCategory = "category"
    static let kApiKey = "apiKey"
}
