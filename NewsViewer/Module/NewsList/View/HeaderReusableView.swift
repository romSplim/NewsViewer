//
//  HeaderReusableView.swift
//  NewsViewer
//
//  Created by ramil on 24.06.2023.
//

import UIKit

final class HeaderReusableView: UICollectionReusableView {
    
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setLabelText(_ text: String) {
        titleLabel.text = text
    }
    
    //MARK: - Private methods
    private func setupSubviews() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:  16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:  10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
