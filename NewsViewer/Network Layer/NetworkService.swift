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
    func getNewsList(endpoint: APIManager, completion: @escaping (Result<WrappedModel, NetworkError>) -> Void) {
        guard let request = endpoint.request() else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            
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
