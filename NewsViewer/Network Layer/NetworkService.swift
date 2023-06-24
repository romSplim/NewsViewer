//
//  NetworkService.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import Foundation

final class NetworkService {
    
    //MARK: - Properties
    private var session: URLSession
    private var decoder: JSONDecoder
    
    //MARK: - Init
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder()) {
        
        self.session = session
        self.decoder = decoder
    }
    
    //MARK: - Methods
    
    func getTopNews(completion: @escaping (Result<WrappedModel, NetworkError>) -> Void) {
        guard let request = APIManager.getTopNews.request() else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let result = try self.decoder.decode(WrappedModel.self,
                                                         from: data)
                    completion(.success(result))
                } catch let error {
                    print(error)
                    completion(.failure(.cannotDecode))
                }
            }
        }.resume()
    }
    
    func getNewsList(completion: @escaping (Result<WrappedModel, NetworkError>) -> Void) {
        guard let request = APIManager.getLatestNews.request() else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let result = try self.decoder.decode(WrappedModel.self,
                                                         from: data)
                    completion(.success(result))
                } catch let error {
                    print(error)
                    completion(.failure(.cannotDecode))
                }
            }
        }.resume()
    }
}
