//
//  PersistedArticle.swift
//  NewsViewer
//
//  Created by ramil on 23.06.2023.
//

import Foundation
import RealmSwift

final class PersistedArticle: Object {
//    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(primaryKey: true) var title: String?
    @Persisted var link: String?
    @Persisted var creator = List<String>()
    @Persisted var descriptions: String?
    @Persisted var content: String?
    @Persisted var pubDate: String?
    @Persisted var imageURL: String?
    
    convenience init(title: String?,
                     link: String?,
                     creator: List<String>,
                     descriptions: String,
                     content: String,
                     pubDate: String,
                     imageURL: String) {
        self.init()
        self.title = title
        self.link = link
        self.creator = creator
        self.descriptions = descriptions
        self.content = content
        self.pubDate = pubDate
        self.imageURL = imageURL
    }
    
    
}

//MARK: - Mapping init
extension PersistedArticle {
    convenience init(_ dto: Article) {
        self.init()
        self.title = dto.title
        self.link = dto.link
        self.creator.append(objectsIn: dto.creator ?? [])
        self.descriptions = dto.description ?? ""
        self.content = dto.content ?? ""
        self.pubDate = dto.pubDate
        self.imageURL = dto.imageURL ?? ""
    }
}

