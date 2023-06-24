//
//  DetailArticleController.swift
//  NewsViewer
//
//  Created by ramil on 23.06.2023.
//

import UIKit

protocol DetailArticleView: AnyObject {
    func setupDetailView(with: Article)
    func applyButtonState(_ state: LikeBarButtonItem.ContentState)
}

final class DetailArticleController: UIViewController {

    //MARK: - Properties
    var presenter: DetailArticlePresenter?
    private let detailView = DetailView()
    private let likeBarButtonItem = LikeBarButtonItem()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
//        scrollView.contentSize = myContentSize
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var myContentSize: CGSize {
        .init(width: view.frame.width, height: view.frame.height + 400)
    }
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupLikeItem()
        view.backgroundColor = .white
        presenter?.onViewDidLoad()
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.checkIfArticleExist()
    }
    
    //MARK: - Private methods
    @objc
    private func favoriteButtonTapped() {
        presenter?.handleFavoriteButtonTap()
    }
    
    private func setupLikeItem() {
        likeBarButtonItem.target = self
        likeBarButtonItem.action = #selector(favoriteButtonTapped)
        
        navigationItem.rightBarButtonItem = likeBarButtonItem
    }
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            detailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            detailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

extension DetailArticleController: DetailArticleView {
    func applyButtonState(_ state: LikeBarButtonItem.ContentState) {
        likeBarButtonItem.setState(state)
    }
    
    func setupDetailView(with: Article) {
        detailView.setup(with: with)
    }
}
