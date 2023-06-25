//
//  NewsListController.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import UIKit

protocol NewsListViewProtocol: AnyObject {
    func reloadItems()
}

final class NewsListController: UIViewController {
    
    //MARK: - Typealias
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Article>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Article>
    
    //MARK: - Properties
    var presenter: NewsListPresenter?
    private var dataSource: DataSource?
    
    private let sections = [Section(type: .banner),
                            Section(type: .list)]
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: setupSectionsLayout())
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TopArticleCell.self, forCellWithReuseIdentifier: TopArticleCell.identifier)
        collectionView.register(LatestArticleCell.self, forCellWithReuseIdentifier: LatestArticleCell.identifier)
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.identifier)
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupDiffableDataSource()
        presenter?.loadNews()
        reloadItems()
    }
    
    //MARK: - Private methods
    private func applySnapshot(animatingDifferences: Bool = true) {
        
        guard let topNews = presenter?.getTopNews(),
              let latestNews = presenter?.getLatestNews() else { return }
        var snapshot = Snapshot()
        
        snapshot.appendSections(sections)
        snapshot.appendItems(topNews, toSection: sections[0])
        snapshot.appendItems(latestNews, toSection: sections[1])
        
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func setupDiffableDataSource() {
        dataSource = DataSource(
            collectionView: collectionView) { [weak self] collectionView, indexPath, article in
                guard let self else { return UICollectionViewCell() }
                let section = self.sections[indexPath.section]
                switch section.type {
                case .banner:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopArticleCell.identifier, for: indexPath) as? TopArticleCell else {
                        return UICollectionViewCell()
                    }
                    cell.configure(with: article)
                    return cell
                    
                case .list:
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestArticleCell.identifier, for: indexPath) as? LatestArticleCell else {
                        return UICollectionViewCell()
                    }
                    cell.configure(with: article)
                    return cell
                }
            }
        
        dataSource?.supplementaryViewProvider = { [weak self] collection, kind, indexPath -> UICollectionReusableView? in
            guard let self else { return UICollectionReusableView() }
            
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                guard let header = collection.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as? HeaderReusableView else {
                    return UICollectionReusableView()
                }
                let headerText = self.sections[indexPath.section].headerText
                header.setLabelText(headerText)
                
                return header
            default:
                return nil
            }
        }
    }
    
    private func setupSectionsLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { index, enviroment in
            
            let section = self.sections[index]
            switch section.type {
            case .banner:
                return LayoutBuilder.buildTopSectionLayout()
            case .list:
                return LayoutBuilder.buildLatestSectionLayout()
            }
        }
        return layout
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UICollectionView Delegate
extension NewsListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard let articleDetail = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        presenter?.showArticleDetail(with: articleDetail)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        guard let section = collectionView.indexPathsForVisibleItems.first?.section else { return
        }
        let itemsCount = collectionView.numberOfItems(inSection: section)
        if indexPath.item == itemsCount - 1 {
            presenter?.loadNewsFromNextPage()
        }
    }
    
}

//MARK: - NewsListPresenter delegate
extension NewsListController: NewsListViewProtocol {
    
    func reloadItems() {
        DispatchQueue.main.async {
            self.applySnapshot()
        }
    }
}
