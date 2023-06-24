//
//  FavoriteArticlePresenter.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import UIKit

final class FavoriteArticlePresenter {
    
    //MARK: - Properties
    private weak var view: FavoriteArticleController?
    private var router: FavoriteArticleRouter
    private var realmRepository: FavoriteNewsRepository
    
    private var favoriteNews: [Article]?
    
    //MARK: - Init
    init(view: FavoriteArticleController,
         router: FavoriteArticleRouter,
         realmRepository: FavoriteNewsRepository) {
        
        self.view = view
        self.router = router
        self.realmRepository = realmRepository
    }
    
    //MARK: - Methods
    func handleEditingActionCell(with indexPath: IndexPath,
                                 editingStyle: UITableViewCell.EditingStyle) {
        switch editingStyle {
        case .delete:
            guard let article = getFavoriteArticle(with: indexPath) else {
                break
            }
            realmRepository.deleteArticle(article)
            favoriteNews = realmRepository.getNewsList()
            view?.removeRowAt([indexPath])
        default:
            break
        }
    }
    
    func fetchNews() {
        favoriteNews = realmRepository.getNewsList()
        print(favoriteNews)
        self.view?.reloadTable()
    }
    
    func getFavoriteArticle(with indexPath: IndexPath) -> Article? {
        return favoriteNews?[indexPath.row]
    }
    
    func getFavoriteNewsCount() -> Int {
        return favoriteNews?.count ?? 0
    }
    
    func showPhotoDetails(with articleDetail: Article) {
        guard let view else { return }
        router.pushDetailController(from: view, with: articleDetail)
    }
    
}
