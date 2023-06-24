//
//  FavoriteArticleController.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import UIKit

protocol FavoriteArticleViewProtocol {
    func reloadTable()
    func removeRowAt(_ indexPaths: [IndexPath])
}

final class FavoriteArticleController: UIViewController {
    
    //MARK: - Properties
    var presenter: FavoriteArticlePresenter?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteArticleCell.self,
                           forCellReuseIdentifier: FavoriteArticleCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        view.backgroundColor = .green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchNews()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UITableViewDataSource
extension FavoriteArticleController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getFavoriteNewsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteArticleCell.identifier, for: indexPath) as? FavoriteArticleCell,
            let article = presenter?.getFavoriteArticle(with: indexPath) else {
            return UITableViewCell()
        }
        
        cell.configure(with: article)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FavoriteArticleController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let photo = presenter?.getFavoriteArticle(with: indexPath) {
            presenter?.showPhotoDetails(with: photo)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        presenter?.handleEditingActionCell(with: indexPath,
                                           editingStyle: editingStyle)
    }
}

//MARK: - FavoriteArticlePresenter delegate
extension FavoriteArticleController: FavoriteArticleViewProtocol {
    func removeRowAt(_ indexPaths: [IndexPath]) {
        tableView.deleteRows(at: indexPaths, with: .fade)
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
}
