//
//  TabBarController.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    //MARK: - Properties
    private let tabs = TabBarItem.allCases
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Private methods
    private func setup() {
        viewControllers = tabs.map { tab in
            
            switch tab {
            case .newsList:
                let vc = ModuleBuilder.buildNewsListModule()
                vc.tabBarItem.image = tab.icon
                vc.title = tab.title
                return UINavigationController(rootViewController: vc)
                
            case .favoriteArticle:
                let vc = ModuleBuilder.buildFavoriteArticleModule()
                vc.tabBarItem.image = tab.icon
                vc.title = tab.title
                return UINavigationController(rootViewController: vc)
            }
        }
    }
}

extension TabBarController {
    enum TabBarItem: CaseIterable {
        case newsList
        case favoriteArticle
        
        var title: String {
            switch self {
            case .newsList:
                return "News"
            case .favoriteArticle:
                return "Favorite article"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .newsList:
                return UIImage(systemName: "photo.stack")
            case .favoriteArticle:
                return UIImage(systemName: "star")
            }
        }
    }
}
