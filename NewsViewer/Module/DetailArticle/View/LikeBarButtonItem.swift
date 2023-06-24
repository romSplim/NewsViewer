//
//  LikeBarButtonItem.swift
//  NewsViewer
//
//  Created by ramil on 24.06.2023.
//

import UIKit

final class LikeBarButtonItem: UIBarButtonItem {

    enum ContentState {
        case add
        case delete
    }
    
    //MARK: - Properties
    private var state: ContentState = .add {
        didSet {
            applyState()
        }
    }
    
    //MARK: - Init
    override init() {
        super.init()
        applyState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setState(_ state: ContentState) {
        self.state = state
    }
    
    //MARK: - Private methods
    private func applyState() {
        switch state {
        case .add:
            image = UIImage(systemName: "heart")?
                .withTintColor(.red,
                               renderingMode: .alwaysOriginal)
            
        case .delete:
            image = UIImage(systemName: "heart.fill")?
                .withTintColor(.red,
                               renderingMode: .alwaysOriginal)
        }
    }
}
