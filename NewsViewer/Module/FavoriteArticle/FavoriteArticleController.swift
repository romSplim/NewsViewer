//
//  FavoriteArticleController.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import UIKit

protocol FavoriteArticleViewProtocol {}

final class FavoriteArticleController: UIViewController {
    
    //MARK: - Properties
    var presenter: FavoriteArticlePresenter?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    


}

//MARK: - FavoriteArticlePresenter delegate
extension FavoriteArticleController: FavoriteArticleViewProtocol {
    
}
