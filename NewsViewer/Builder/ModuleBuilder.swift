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
        let presenter = NewsListPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func buildFavoriteArticleModule() -> UIViewController {
        let view = FavoriteArticleController()
        let presenter = FavoriteArticlePresenter(view: view)
        view.presenter = presenter
        return view
    }
}
