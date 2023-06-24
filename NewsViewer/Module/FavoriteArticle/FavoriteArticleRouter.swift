//
//  FavoriteArticleRouter.swift
//  NewsViewer
//
//  Created by ramil on 23.06.2023.
//

import UIKit

final class FavoriteArticleRouter {
    
    //MARK: - Methods
    func pushDetailController(from vc: UIViewController,
                              with article: Article) {
        
        let detailPhotoController = ModuleBuilder.buildDetailArticleModule(with: article)
        vc.navigationController?.pushViewController(detailPhotoController,
                                                    animated: true)
    }
}
