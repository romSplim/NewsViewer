//
//  NewsListPresenter.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import Foundation

final class NewsListPresenter {
    
    //MARK: - Properties
    private weak var view: NewsListController?
    private var networkService: NetworkService
    private var router: NewsListRouter
    
    private var topNews: WrappedModel?
    private var latestNews: WrappedModel?
    
    private var isDataLoading = false
    private var isNeededToLoadNextCompanies = true
    
    //MARK: - Init
    init(view: NewsListController,
         networkService: NetworkService,
         router: NewsListRouter) {
        
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    //MARK: - Methods
    func getTopNews() -> [Article] {
        return topNews?.results ?? [Article]()
    }
    
    func getLatestNews() -> [Article] {
        return latestNews?.results ?? [Article]()
    }
    
    func loadNews() {
        let group = DispatchGroup()
        
        let blocks: [(@escaping() -> Void) -> Void] = [loadTopArticles,
                                                       loadLatestArticles]
        
        for block in blocks {
            group.enter()
            block {
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.view?.reloadItems()
        }
    }
    
    func showArticleDetail(with article: Article) {
        guard let view else { return }
        router.pushDetailController(from: view,
                                    with: article)
    }
    
    func loadNewsFromNextPage() {
        guard !isDataLoading && isNeededToLoadNextCompanies else {
            return
        }
        isDataLoading = true
        defer { self.isDataLoading = false }
        
        networkService.getNewsList(endpoint: .getNextLatestNews(page: latestNews?.nextPage ?? "")) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.latestNews?.appendItems(success.results)
                self.latestNews?.updateNextPage(success.nextPage)
                self.view?.reloadItems()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    //MARK: - Private methods
    private func loadTopArticles(completion: @escaping () -> Void) {
        networkService.getNewsList(endpoint: .getTopNews) { [weak self]
            result in
            guard let self else { return }
            
            switch result {
            case .success(let success):
                self.topNews = success
                completion()
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func loadLatestArticles(completion: @escaping () -> Void) {
        networkService.getNewsList(endpoint: .getLatestNews) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let success):
                self.latestNews = success
                completion()
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
