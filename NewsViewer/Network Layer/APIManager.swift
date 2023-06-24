//
//  APIManager.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import Foundation

enum APIManager {
    case getLatestNews
    case getTopNews
    
    typealias HTTPHeaders = [String: String]
    
    var baseUrl: String {
        return "https://newsdata.io/"
    }
    
    private var path: String {
        switch self {
        case .getLatestNews:
            return "/api/1/news"
        case .getTopNews:
            return "/api/1/news"
        }
    }
    
    private var headers: HTTPHeaders {
        return ["X-ACCESS-KEY": "pub_2490936e85206e84c86708ad30c221cf211cb"]
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .getLatestNews:
            return [URLQueryItem(name: "language", value: "ru")]
            
        case .getTopNews:
            return [URLQueryItem(name: "language",
                                 value: "ru"),
                    URLQueryItem(name: "category",
                                 value: "technology")]
        }
    }
    
    private var url: URL? {
        var components = URLComponents(string: baseUrl)
        components?.path = path
        components?.queryItems = queryItems
        return components?.url
    }
    
    func request() -> URLRequest? {
        guard let url = url else { return nil }
        print(url)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        return request
    }
    
}
