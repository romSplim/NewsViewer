//
//  NewsListController.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import UIKit

protocol NewsListViewProtocol: AnyObject {
    
}

final class NewsListController: UIViewController {

    var presenter: NewsListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    


}

//MARK: - NewsListPresenter delegate
extension NewsListController: NewsListViewProtocol {
    
}
