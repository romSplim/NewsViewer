//
//  DetailArticlePresenter.swift
//  NewsViewer
//
//  Created by ramil on 23.06.2023.
//

import UIKit
import RealmSwift

final class DetailArticlePresenter {
    
    //MARK: - Properties
    private weak var view: DetailArticleController?
    private var repository: FavoriteNewsRepository
    private var articleDetail: Article
    
    private var isArticleLiked: Bool = false {
        didSet {
            updateLikeBarButton()
        }
    }
    
    //MARK: - Init
    init(view: DetailArticleController,
         repository: FavoriteNewsRepository,
         articleDetail: Article) {
        
        self.view = view
        self.repository = repository
        self.articleDetail = articleDetail
    }
    
    //MARK: - Methods
    func onViewDidLoad() {
        view?.setupDetailView(with: articleDetail)
    }
    
    private func updateLikeBarButton() {
        let state: LikeBarButtonItem.ContentState = isArticleLiked ? .delete: .add
        self.view?.applyButtonState(state)
    }
    
    func handleFavoriteButtonTap() {
        if isArticleLiked {
            deleteArticleFromFavorite()
        } else {
            addArticleToFavorite()
        }
    }
    
    func addArticleToFavorite() {
        repository.saveArticle(articleDetail)
        isArticleLiked = true
    }
    
    func deleteArticleFromFavorite() {
        repository.deleteArticle(articleDetail)
        isArticleLiked = false
    }
    
    func checkIfArticleExist() {
        let articleID = articleDetail.title
        let photoExist = repository.isFavoriteArticleExist(with: articleID)
        isArticleLiked = photoExist
    }
}
