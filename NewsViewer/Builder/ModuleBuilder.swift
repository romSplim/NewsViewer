//
//  ModuleBuilder.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import UIKit

final class ModuleBuilder {
    
    //MARK: - Methods
    static func buildNewsListModule() -> UIViewController {
        let view = NewsListController()
        let networkService = NetworkService()
        let router = NewsListRouter()
        let presenter = NewsListPresenter(view: view,
                                          networkService: networkService,
                                          router: router)
        view.presenter = presenter
        return view
    }
    
    static func buildFavoriteArticleModule() -> UIViewController {
        let view = FavoriteArticleController()
        let router = FavoriteArticleRouter()
        let repository = FavoriteNewsRepository()
        let presenter = FavoriteArticlePresenter(view: view,
                                                 router: router,
                                                 realmRepository: repository)
        view.presenter = presenter
        return view
    }
    
    static func buildDetailArticleModule(with articleDetail: Article) -> UIViewController {
        let view = DetailArticleController()
        let repository = FavoriteNewsRepository()
        let presenter = DetailArticlePresenter(view: view,
                                               repository: repository, articleDetail: articleDetail)
        view.presenter = presenter
        return view
    }
}
