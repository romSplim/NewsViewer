//
//  NewsListRouter.swift
//  NewsViewer
//
//  Created by ramil on 23.06.2023.
//

import UIKit

final class NewsListRouter {
    
    //MARK: - Methods
    func pushDetailController(from vc: UIViewController,
                              with articleDetail: Article) {
        
        let detailArticleController = ModuleBuilder.buildDetailArticleModule(with: articleDetail)
        vc.navigationController?.pushViewController(detailArticleController,
                                                    animated: true)
    }
}
