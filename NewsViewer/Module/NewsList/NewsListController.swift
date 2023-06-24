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
    
    enum SectionType: Int, CaseIterable {
        case banner
        case list
    }
    
    struct Section: Hashable, Equatable {
        let id = UUID()
        let type: SectionType
        var headerText: String {
            switch type {
            case .banner:
                return "Технологии"
            case .list:
                return "Последние"
            }
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
//    private let sections: [Section] = Section.allCases
    private let sections = [Section(type: .banner),
                            Section(type: .list)]
    
    //MARK: - Properties
    var presenter: NewsListPresenter?
    var dataSource: DataSource?
    
    
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
            collectionView: collectionView) { collectionView, indexPath, article  in

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
        
        dataSource?.supplementaryViewProvider = { collection, kind, indexPath -> UICollectionReusableView? in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collection.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as! HeaderReusableView
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
            print(index)
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

extension NewsListController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard let articleDetail = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        presenter?.showArticleDetail(with: articleDetail)
    }
}

//MARK: - NewsListPresenter delegate
extension NewsListController: NewsListViewProtocol {
    func reloadItems() {
        applySnapshot()
    }
    
    
}
