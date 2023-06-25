//
//  WrappedModel.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import Foundation
import RealmSwift

// MARK: - WrappedModel
struct WrappedModel: Decodable {
    let status: String
    let totalResults: Int
    var results: [Article]
    var nextPage: String
}

// MARK: - Result
struct Article: Decodable {
    let id = UUID()
    let title: String
    let link: String
    let creator: [String]?
    let description: String?
    let content: String?
    let pubDate: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case title, link, creator
        case description, content, pubDate
        case imageURL = "image_url"
    }
}

extension WrappedModel {
    mutating func appendItems(_ items: [Article]) {
        results.append(contentsOf: items)
    }
    
    mutating func updateNextPage(_ page: String) {
        nextPage = page
    }
}

extension Article: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Article {
    init(object: PersistedArticle) {
        self.title = object.title ?? ""
        self.link = object.link ?? ""
        self.creator = Array(object.creator)
        self.description = object.descriptions ?? ""
        self.content = object.content ?? ""
        self.pubDate = object.pubDate ?? ""
        self.imageURL = object.imageURL ?? ""
    }
}

