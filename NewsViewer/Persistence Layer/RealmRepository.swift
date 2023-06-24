//
//  RealmRepository.swift
//  NewsViewer
//
//  Created by ramil on 23.06.2023.
//

import Foundation
import RealmSwift

final class FavoriteNewsRepository {
    
    //MARK: - Properties
    private let storage: StorageService
    
    //MARK: - Init
    init(storage: StorageService = StorageService()) {
        self.storage = storage
    }
    
    //MARK: - Methods
    func getNewsList() -> [Article] {
        let data = storage.fetch(by: PersistedArticle.self)
        return data.map(Article.init)
    }
    
    func saveArticle(_ article: Article) {
        let object = PersistedArticle.init(article)
        print(object)
        try? storage.saveOrUpdateObject(object: object)
    }
    
    func deleteArticle(_ article: Article) {
        let object = PersistedArticle(article)
        try? storage.delete(object: object)
    }
    
    func clearNewsList() {
        try? storage.deleteAll()
    }
    
    func isFavoriteArticleExist(with id: String) -> Bool {
        storage.isObjectExist(by: PersistedArticle.self, with: id)
    }
}
